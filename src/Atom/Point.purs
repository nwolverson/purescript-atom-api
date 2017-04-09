module Atom.Point where

foreign import data Point :: Type

foreign import getRow :: Point -> Int
foreign import getColumn :: Point -> Int
foreign import mkPoint :: Int -> Int -> Point
