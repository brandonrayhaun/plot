import Plot (..)
import Types (..)
import LinePlot as LP
import Text (..)
import List as L
import Graphics.Collage (..)
import Color (..)
import Debug (..)
import Signal as S
import Time (..)
import Window

xpoints = linspace -3 3 100
ypoints = L.map (\x -> (3*x^5 - 20*x^3)/32) xpoints

example1 : List Float -> LinePlot
example1 ys = LP.plot xpoints ys 
    |> LP.lineColor green
    |> LP.lineWidth 6
    |> LP.markerSize 5

example2 : LinePlot
example2 = LP.plot xpoints ypoints
    |> LP.lineColor blue
    |> LP.lineWidth 6

timeElapsed : Signal Float
timeElapsed = S.foldp (+) 0 <| fps 30

d : Signal (Int, Int)
d = Window.dimensions

ax pl = axes 
    |> LP.addPlots pl
    |> title "Hello"
    |> xTick [-2,-1,0,1,2]
    |> yTick [5,-5]
    |> yLimits (-6,6)
    |> xLimits (-2.8,2.8)

-- Examples
main = S.map2 (\(d1,d2) t -> showA (toFloat d1, toFloat d2) <| ax <| [example1 <| L.map ((*) (3*sin(t/200))) ypoints,example2]) d timeElapsed