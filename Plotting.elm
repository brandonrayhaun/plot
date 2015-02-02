module Plotting where

import Graphics.Element (..)
import Graphics.Collage (..)
import Color (..)
import List as L
import Text as T

type Marker    = Circle | Shell  | Square | Triangle | NoMarker

type alias LinePlot = {
    x           : List Float,
    y           : List Float,
    lineStyle   : LineStyle,
    marker      : Marker,
    markerSize  : Float,
    markerColor : Color
}

-- finish writing this
type alias BarPlot = {
    x : List Float,
    y : List Float
}

type alias Axes = {
    linePlots   : List LinePlot,
    barPlots    : List BarPlot,
    xTick       : List Float,
    yTick       : List Float,
    xLim        : (Float, Float),
    yLim        : (Float, Float)
}

type alias Figure = {
    axes        : List Axes,
    plotSizes   : List (Int, Int),
    coordinates : List
}

showL : LinePlot -> Form
showL p = case p.marker of
    NoMarker -> toForm <| T.plainText "Not yet supported."
    _ -> toForm <| T.plainText "Not yet supported."


lineColor : Color -> LinePlot -> LinePlot
lineColor c p = 
    let pls = p.lineStyle in { p | lineStyle <- { pls | color <- c } }

lineWidth : Float -> LinePlot -> LinePlot
lineWidth w p =
    let pls = p.lineStyle in { p | lineStyle <- { pls | width <- w } }

plotL : List Float -> List Float -> LinePlot
plotL xs ys = 
    let 
        xExtent = L.maximum xs - L.minimum xs
        yExtent = L.maximum ys - L.minimum ys
    in
        {
            x           = xs,
            y           = ys,
            lineStyle   = defaultLine,
            marker      = NoMarker, 
            markerSize  = 1,
            markerColor = blue
        }


{--show : 
        axis = {
            plots = [plot2d],
            xTick = L.map (\x -> x*xExtent + minimum xs) [0..4]
            yTick = L.map (\x -> y*yExtent + minimum ys) [0..4]
            xLim  = (minimum xs - xExtent/5, maximum xs + xExtent/5)
            yLim  = (minimum ys - yExtent/5, maximum ys + yExtent/5)
        }--}
