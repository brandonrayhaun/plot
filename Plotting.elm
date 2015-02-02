module Plotting where

import Graphics.Element (..)
import Graphics.Collage (..)
import Color (..)
import List as L

type Widget = Figure F | Axes A | Plot2D P

type LineStyle = Normal | Dashed | Dotted | DashDotted | NoLine
type Marker    = Circle | Shell  | Square | Triangle   | NoMarker

type alias P = {
    x           : List Float,
    y           : List Float,
    lineColor   : Color,
    lineWidth   : Float,
    lineStyle   : LineStyle,
    marker      : Marker,
    markerSize  : Float,
    markerColor : Color
}

type alias A = {
    plots       : List P,
    xTick       : List Float,
    yTick       : List Float,
    xLim        : (Float, Float),
    yLim        : (Float, Float)
}

type alias F = {
    axes        : List A,
    plotSizes   : List (Int, Int),
    coordinates : List
}

plot : List Float -> List Float -> Widget
plot xs ys = 
    let 
        xExtent = L.maximum xs - L.minimum xs
        yExtent = L.maximum ys - L.minimum ys
    in
        Plot2D {
            x           = xs,
            y           = ys,
            lineColor   = green,
            lineWidth   = 1,
            lineStyle   = Normal,
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
