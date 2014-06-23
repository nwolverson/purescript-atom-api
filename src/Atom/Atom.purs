module Atom.Atom where

import Atom.Clipboard
import Control.Monad.Eff

data Mode
  = Editor
  | Spec

type Atom = forall r. { clipboard :: Clipboard | r }

foreign import getAtom
  "function getAtom() {\
  \  return atom;\
  \}" :: forall e. Eff e Atom
