module Atom.ContextMenuManager where

import Prelude (Unit)
import Control.Monad.Eff (Eff)

foreign import data ContextMenuManager :: *
foreign import data ContextMenu        :: *
foreign import data Event              :: *

type ContextMenuOptions = forall r. { devMode :: Boolean | r }

foreign import add :: forall e. ContextMenuManager -> String -> ContextMenu -> Eff e Unit

foreign import showForEvent :: forall e. ContextMenuManager -> Event -> Eff e Unit
