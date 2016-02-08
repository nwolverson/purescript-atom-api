module Atom.Atom where

import Atom.Clipboard (Clipboard)
import Control.Monad.Eff (Eff)

data Mode
  = Editor
  | Spec

type Atom = forall r. { clipboard :: Clipboard | r }

foreign import getAtom :: forall e. Eff e Atom
