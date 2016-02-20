module Atom.Point where

foreign import data Point :: *

foreign import getRow :: Point -> Int
foreign import getColumn :: Point -> Int
foreign import mkPoint :: Int -> Int -> Point
--foreign import fromPointLikeImpl :: forall p. (PointLike p) => p -> Point

--
-- class PointLike p where
--   getRow :: p -> Int
--   getColumn :: p -> Int
--   makePoint :: Int -> Int -> p
--   fromPointLike :: p -> Point
--
-- instance pointPointLike :: PointLike Point
--   getRow = getRowImpl
--   getColumn = getColumnImpl
--   makePoint = mkPoint
--   fromPointLike = id
--
-- instance arrayPointLike :: PointLike (Array Int)
--   getRow [r, _] = r
--   getRow _ = -1
--
--   getColumn [_, c] = c
--   getColumn _ = -1
--
--   makePoint r c = [r,c]
--
--   fromPointLike = fromPointLikeImpl
