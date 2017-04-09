module Atom.Grammar where

import Control.Monad.Eff (kind Effect)

foreign import data Grammar :: Type
foreign import data GRAMMAR :: Effect
