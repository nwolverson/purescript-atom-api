module Atom.Range (getStart, getEnd, mkRange, containsPoint, Range) where

import Data.Function.Uncurried (Fn2, runFn2)
import Atom.Point (Point)

foreign import data Range :: *

foreign import getStart :: Range -> Point
foreign import getEnd :: Range -> Point
foreign import mkRangeImpl :: Fn2 Point Point Range
foreign import containsPoint :: Range -> Point -> Boolean

mkRange :: Point -> Point -> Range
mkRange = runFn2 mkRangeImpl
