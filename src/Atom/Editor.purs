module Atom.Editor (TextEditor, EDITOR, getTitle, getLongTitle, getPath, getText, getTextInRange, setTextInBufferRange, toEditor, onDidSave) where

import Prelude((<<<),Unit)
import Control.Monad.Eff(Eff)
import Data.Maybe (Maybe(..))
import Data.Foreign (Foreign)
import Unsafe.Coerce(unsafeCoerce)
import Atom.Range (Range)
import Data.Function.Eff (EffFn1, EffFn2, mkEffFn1, runEffFn1, runEffFn2)

foreign import data TextEditor :: *
foreign import data EDITOR :: !

foreign import getTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getLongTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getPath :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getText :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String


foreign import getTextInRangeImpl :: forall eff. TextEditor -> EffFn1 (editor :: EDITOR | eff) Range String

getTextInRange :: forall eff. TextEditor -> Range -> Eff (editor :: EDITOR | eff) String
getTextInRange = runEffFn1 <<< getTextInRangeImpl

foreign import setTextInBufferRangeImpl :: forall eff. TextEditor -> EffFn2 (editor :: EDITOR | eff) Range String Range

setTextInBufferRange :: forall eff. TextEditor -> Range -> String -> Eff (editor :: EDITOR | eff) Range
setTextInBufferRange = runEffFn2 <<< setTextInBufferRangeImpl

foreign import onDidSaveImpl :: forall eff. TextEditor
  -> EffFn1 (editor :: EDITOR | eff) (EffFn1 (editor ::EDITOR | eff) { path :: String} Unit) Unit

onDidSave :: forall eff. TextEditor -> ({path :: String} -> Eff (editor :: EDITOR | eff) Unit)
  ->Eff (editor :: EDITOR | eff) Unit
onDidSave e f = runEffFn1 (onDidSaveImpl e) (mkEffFn1 f)


toEditor :: Foreign -> Maybe TextEditor
toEditor item =
  if isTextEditor item then
    Just (unsafeCoerce item)
  else
    Nothing

foreign import isTextEditor :: Foreign -> Boolean
