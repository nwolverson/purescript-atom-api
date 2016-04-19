module Atom.Pane (Pane, PANE, destroyItem) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Eff (EffFn1, runEffFn1)

foreign import data Pane :: *
foreign import data PANE :: !


foreign import destroyItemImpl :: forall eff a. Pane -> EffFn1 (pane :: PANE | eff) a Boolean

destroyItem :: forall eff a. Pane -> a -> Eff (pane :: PANE | eff) Boolean
destroyItem = runEffFn1 <<< destroyItemImpl
