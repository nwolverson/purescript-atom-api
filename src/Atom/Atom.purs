module Atom.Atom where

import Atom.Clipboard (Clipboard)
import Atom.NotificationManager (NotificationManager)
import Control.Monad.Eff (Eff)

data Mode
  = Editor
  | Spec

type Atom =
  { clipboard :: Clipboard
  , notifications :: NotificationManager }

foreign import getAtom :: forall e. Eff e Atom
