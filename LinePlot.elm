module LinePlot where

import Types (..)
import Color (..)
import List as L
import Graphics.Collage (..)
import Maybe (..)
import Debug (..)
import Text (..)


lineColor : Color -> LinePlot -> LinePlot
lineColor c p = 
    let pls = p.lineStyle in { p | lineStyle <- { pls | color <- c } }


lineWidth : Float -> LinePlot -> LinePlot
lineWidth w p =
    let pls = p.lineStyle in { p | lineStyle <- { pls | width <- w } }


line : Bool -> LinePlot -> LinePlot
line b p = { p | line <- b }


lineStyle : LineStyle -> LinePlot -> LinePlot
lineStyle l p = { p | lineStyle <- l }


marker : Marker -> LinePlot -> LinePlot
marker m p = { p | marker <- m }


markerSize : Float -> LinePlot -> LinePlot
markerSize s p = { p | markerSize <- s }


markerColor : Color -> LinePlot -> LinePlot
markerColor c p = { p | markerColor <- c }


toPlot : LinePlot -> Plot 
toPlot p = LP p


fromPlot : Plot -> Maybe LinePlot
fromPlot p = case p of
    LP lp -> Just lp
    _     -> Nothing


addPlots : List LinePlot -> Axes -> Axes
addPlots lps a = 
    let updatedPlots = L.append a.plots <| L.map toPlot lps
    in { a | plots <- updatedPlots }


getLinePlots : Axes -> List LinePlot
getLinePlots a = 
    L.filterMap fromPlot a.plots


plot : List Float -> List Float -> LinePlot
plot xs ys = 
    {
        x           = xs,
        y           = ys,
        line        = True,
        lineStyle   = defaultLine,
        marker      = NoMarker, 
        markerSize  = 1,
        markerColor = blue
    }

-- HIDE THIS
safe : (List Float -> Float) -> List Float -> List Float
safe f ss = if L.isEmpty ss
    then []
    else [f ss]

-- HIDE THIS 
plotToForms : (Float, Float) -> (Float, Float) -> (Float, Float) -> LinePlot -> List Form
plotToForms (xmin, xmax) (ymin, ymax) (sx, sy) p =
    let
        adjustX      = \x -> (sx_/(xmax-xmin))*(x-xmin) - sx_/2
        adjustY      = \y -> (sy_/(ymax-ymin))*(y-ymin) - sy_/2
        sx_          = sx*(3.8/5)
        sy_          = sy*(3.8/5)
        xExtent      = xmax - xmin
        yExtent      = ymax - ymin
        adjustedX    = L.map adjustX p.x
        adjustedY    = L.map adjustY p.y
        points       = L.map2 (,) adjustedX adjustedY
        line = if p.line then [traced p.lineStyle <| path points] else []
    in 
        line ++ case p.marker of
            NoMarker -> []
            Circle   -> L.map (\x -> move x <| filled p.markerColor <| circle p.markerSize) points
            NGon n   -> L.map (\x -> move x <| filled p.markerColor <| ngon n p.markerSize) points
            Shell    -> L.map 
                (\x -> move x <| outlined { defaultLine | color <- p.markerColor } <| circle p.markerSize) points












