module Plot where

import Graphics.Element (..)
import Graphics.Collage (..)
import List as L

data Widget = F Figure | A Axes | P Plot2D

data LineStyle = Normal | Dashed | Dotted | DashDotted | None
data Marker    = Circle | Shell  | Square | Triangle   | None

type alias Plot2D = {
    x           : List Float,
    y           : List Float,
    lineColor   : Color,
    lineWidth   : Float,
    lineStyle   : LineStyle,
    marker      : Marker,
    markerSize  : Float,
    markerColor : Color
}

type alias Axes = {
    plots       : List Plot2D,
    xTick       : List Float,
    yTick       : List Float,
    xLim        : (Float, Float),
    yLim        : (Float, Float)
}

type alias Figure = {
    axes        : Axes,
    plotSizes   : List (Int, Int)
    coordinates : List,
}

plot : List Float -> List Float -> Widget
plot xs ys = 
    let 
        xExtent = maximum xs - minimum xs
        yExtent = maximum ys - minimum ys
    in
        P plot2d = {
            x           = xs,
            y           = ys,
            lineColor   = green,
            lineWidth   = 1,
            lineStyle   = Normal,
            marker      = None, 
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
