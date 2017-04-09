module Atom.Project where

import Control.Monad.Eff (Eff, kind Effect)

foreign import data Project :: Type
foreign import data PROJECT :: Effect

foreign import getPaths :: forall eff. Project -> Eff (project :: PROJECT | eff) (Array String)
