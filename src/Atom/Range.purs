module Atom.Range (getStart, getEnd, mkRange, Range) where

import Prelude
import Data.Function
import Atom.Point

foreign import data Range :: *

foreign import getStart :: Range -> Point
foreign import getEnd :: Range -> Point
foreign import mkRangeImpl :: Fn2 Point Point Range

mkRange :: Point -> Point -> Range
mkRange = runFn2 mkRangeImpl

--
-- class RangeLike r where
--   getStart :: (PointLike p) => r -> Point
--   getEnd :: (PointLike p) => r -> Point
--
-- instance rangeLikeRange :: RangeLike Range Point
--   getStart = getStartImpl
--   getEnd = getEndImpl
--
-- instance rangeLikeArray :: (PointLike p) => RangeLike (Array p)
--   getStart [p1, _] = fromPointLike p1
--   getStart _ = mkPoint 0 0
--
--   getEnd [_, p2] = fromPointLike p2
--   getEnd _ = mkPoint 0 0
