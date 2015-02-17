module Types where

import Graphics.Collage (..)
import Color (..)
import Text (..)

type Marker 
    = Circle 
    | Shell  
    | NGon Int
    | NoMarker

type Limits
    = Auto 
    | Explicit (Float, Float)

type Plot 
    = LP LinePlot 
    | BP BarPlot 

-- update this type
type alias BarPlot  = {
    x : List Float,
    y : List Float
}

type alias LinePlot = {
    x           : List Float,
    y           : List Float,
    line        : Bool,
    lineStyle   : LineStyle,
    marker      : Marker,
    markerSize  : Float,
    markerColor : Color
}

type alias Axes = {
    plots     : List Plot,
    xTick     : List Float,
    yTick     : List Float,
    xLimits   : Limits,
    yLimits   : Limits,
    title     : String,
    xLabel    : String,
    yLabel    : String,
    text      : List ((Float, Float), String, Style),
    textStyle : Style 
}

type alias Figure = {
    axes        : List Axes,
    plotSizes   : List (Int, Int),
    coordinates : List (Float, Float)
}