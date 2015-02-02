import Plotting (..)
import Text (..)
import List as L
import Graphics.Collage (..)
import Color (..)

example1 : LinePlot
example1 = plotL [-50..50] [-50..50]
    |> lineColor blue
    |> lineWidth 5

plottt = collage 105 105 [traced example1.lineStyle <| path <| L.map2 (,) example1.x example1.y]

-- Examples
main = plottt