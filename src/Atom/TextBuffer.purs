module Atom.TextBuffer where

import Prelude
import Control.Monad.Eff (Eff)
import Atom.Types (EDITOR)
import Atom.Range (Range)
import Data.Function.Eff (EffFn1, runEffFn1)

foreign import data TextBuffer :: *

foreign import setTextViaDiffImpl :: forall eff. TextBuffer -> EffFn1 (editor :: EDITOR | eff) String Range

setTextViaDiff :: forall eff. TextBuffer -> String -> Eff (editor :: EDITOR | eff) Range
setTextViaDiff = runEffFn1 <<< setTextViaDiffImpl
