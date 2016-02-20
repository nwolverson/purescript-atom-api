module Atom.Project where

import Prelude
import Control.Monad.Eff (Eff)

foreign import data Project :: *
foreign import data PROJECT :: !

foreign import getPaths :: forall eff. Project -> Eff (project :: PROJECT | eff) (Array String)
