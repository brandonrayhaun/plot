module Plot where

import Graphics.Element (..)
import Graphics.Collage (..)
import Color (..)
import List as L
import Text as T
import Types (..)
import LinePlot as LP
import FormatNumber (..)

linspace : Float -> Float -> Int -> List Float
linspace a b n = L.map (\x -> ((b-a)/(toFloat (n-1)))*x + a) [0.0..toFloat n-1]

textStyle : T.Style 
textStyle = {
    typeface = ["Helvetica", "Times New Roman"],
    height   = Nothing,
    color    = black,
    bold     = False,
    italic   = False,
    line     = Nothing
        } 

axes : Axes
axes = {
    plots     = [],
    xTick     = [],
    yTick     = [],
    xLimits   = Auto,
    yLimits   = Auto,
    title     = "",
    xLabel    = "",
    yLabel    = "",
    textStyle = textStyle,
    text      = []
    }

prettyPrint : Float -> String
prettyPrint f = if abs f < 99
    then fixed 1 f
    else exponential 1 f

xLimits : (Float, Float) -> Axes -> Axes
xLimits lim ax = { ax | xLimits <- Explicit lim }

yLimits : (Float, Float) -> Axes -> Axes
yLimits lim ax = { ax | yLimits <- Explicit lim }

xTick : List Float -> Axes -> Axes
xTick xTicks ax = { ax | xTick <- xTicks }

yTick : List Float -> Axes -> Axes
yTick yTicks ax = { ax | yTick <- yTicks }

title : String -> Axes -> Axes
title t ax = { ax | title <- t }

xLabel : String -> Axes -> Axes
xLabel l ax = { ax | xLabel <- l }

yLabel : String -> Axes -> Axes
yLabel l ax = { ax | yLabel <- l }

addText : List ((Float,Float), String) -> Axes -> Axes
addText l ax = 
    let
        new  = L.map (\(p,s) -> (p, s, ax.textStyle)) l
        prev = ax.text
    in
        { ax | text <- prev `L.append` new }

addTextWithStyle : List ((Float,Float), String, T.Style) -> Axes -> Axes
addTextWithStyle l ax = let prev = ax.text in { ax | text <- prev `L.append` l }

autoXLims : Axes -> (Float, Float)
autoXLims ax = 
    let getVal f p = case p of 
        LP lp -> f lp.x
    in (L.minimum <| L.map (getVal L.minimum) ax.plots, L.maximum <| L.map (getVal L.maximum) ax.plots)

autoYLims : Axes -> (Float, Float)
autoYLims ax = 
    let getVal f p = case p of
        LP lp -> f lp.y
    in (L.minimum <| L.map (getVal L.minimum) ax.plots, L.maximum <| L.map (getVal L.maximum) ax.plots)

plots : List Plot -> Axes -> Axes
plots ps ax = { ax | plots <- ps }


showA : (Float, Float) -> Axes -> Element
showA (sx, sy) ax =
    let
        tStyle       = let s = ax.textStyle in { s | height <- Just ((adjustY yExtent)/39) }
        largestYTick = if L.isEmpty ax.yTick then 0 else L.maximum <| L.map abs ax.yTick
        largestXTick = if L.isEmpty ax.xTick then 0 else L.maximum <| L.map abs ax.xTick
        (showYFloat, offY) = if largestYTick > 99 then (exponential 1, yTickHeight*5.5) else (fixed 1, yTickHeight*4)
        (showXFloat, offX) = if largestXTick > 99 then (exponential 1, xTickHeight*3.0) else (fixed 1, xTickHeight*3.0)
        adjustX      = \x -> (sx_/(xmax-xmin))*(x-xmin) - sx_/2
        adjustY      = \y -> (sy_/(ymax-ymin))*(y-ymin) - sy_/2
        xExtent      = xmax - xmin
        yExtent      = ymax - ymin
        plot2Forms (xmin,xmax) (ymin,ymax) (sx,sy) p = case p of
            LP lp -> LP.plotToForms (xmin, xmax) (ymin, ymax) (sx, sy) lp
        (xmin, xmax)  = case ax.xLimits of
            Auto               -> autoXLims ax
            Explicit (min,max) -> (min,max)
        (ymin, ymax)  = case ax.yLimits of
            Auto               -> autoYLims ax
            Explicit (min,max) -> (min,max)
        sx_           = (3.8/5)*sx
        sy_           = (3.8/5)*sy 
        xaxis         = traced defaultLine <| segment (-sx_/2, -sy_/2) ( sx_/2, -sy_/2)
        yaxis         = traced defaultLine <| segment (-sx_/2, -sy_/2) (-sx_/2,  sy_/2) 
        xTickHeight   = (adjustY yExtent)/90
        yTickHeight   = (adjustX xExtent)/90
        xTicksForm    = L.map (\xTick -> traced defaultLine <| 
            segment (xTick, -sy_/2 - xTickHeight) (xTick, -sy_/2 + xTickHeight)) <| L.map adjustX ax.xTick
        yTicksForm    = L.map (\yTick -> traced defaultLine <| 
            segment (-sx_/2 - yTickHeight, yTick) (-sx_/2 + yTickHeight, yTick)) <| L.map adjustY ax.yTick
        xTickLabels   = L.map (\xTick -> move (adjustX xTick, -sy_/2-offX) <| 
            toForm <| T.centered <| T.style tStyle <| T.fromString <| showXFloat xTick) ax.xTick
        yTickLabels   = L.map (\yTick -> move (-sx_/2-offY, adjustY yTick) <| 
            toForm <| T.centered <| T.style tStyle <| T.fromString <| showYFloat yTick) ax.yTick
        plotForms     = L.concat <| 
            L.map (plot2Forms (xmin, xmax) (ymin, ymax) (sx, sy)) ax.plots
        textForms     = L.map (\((x,y),t,s) -> move (adjustX x, adjustY y) <| 
            toForm <| T.leftAligned <| T.style s <| T.fromString t) ax.text
        titleForm     = T.fromString ax.title
            |> T.style tStyle
            |> T.centered
            |> toForm 
            |> move (0,sy_/2)
    in 
        collage (round sx) (round sy) <| 
            plotForms 
            `L.append` [xaxis,yaxis] 
            `L.append` xTicksForm 
            `L.append` yTicksForm 
            `L.append` xTickLabels 
            `L.append` yTickLabels 
            `L.append` textForms
            `L.append` [titleForm]
