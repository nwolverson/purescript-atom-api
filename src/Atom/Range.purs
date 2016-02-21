module Atom.Range (getStart, getEnd, mkRange, Range) where

import Data.Function (Fn2, runFn2)
import Atom.Point (Point)

foreign import data Range :: *

foreign import getStart :: Range -> Point
foreign import getEnd :: Range -> Point
foreign import mkRangeImpl :: Fn2 Point Point Range

mkRange :: Point -> Point -> Range
mkRange = runFn2 mkRangeImpl
