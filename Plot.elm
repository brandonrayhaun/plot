module Plot where

import Graphics.Element (..)
import Graphics.Collage (..)

type alias Plot2D = {
    x           : Array Float,
    y           : Array Float,
    lineColor   : Color,
    lineWidth   : Float,
    lineStyle   : String,
    marker      : String,
    markerSize  : Float,
    markerColor : Color
}

type alias Axes = {
    plots : List Plot2D
    xTick : List Float,
    yTick : List Float,
    xLim  : (Float, Float),
    yLim  : (Float, Float)
}

type alias Figure = {
    
}