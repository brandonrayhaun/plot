module FormatNumber where

{-| This library provides utilities for converting numbers to strings.
# Number formatters
@docs fixed, exponential
-}
import Native.Formatting

{-| `fixed d x` is a string representing `x` with `d` digits
after the decimal point.
-}
fixed : Int -> number -> String
fixed d x = Native.Formatting.toFixed x d

{-| `exponential d x` is a string representing `x` in scientific
notation with `d` digits of precision.
-}
exponential : Int -> number -> String
exponential d x = Native.Formatting.toExponential x d