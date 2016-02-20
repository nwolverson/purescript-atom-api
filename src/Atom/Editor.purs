module Atom.Editor (TextEditor, EDITOR, getTitle, getLongTitle, getPath, getText, getTextInRange, toEditor, onDidSave) where

import Prelude((<<<),Unit)
import Control.Monad.Eff(Eff)
import Data.Maybe (Maybe(..))
import Data.Foreign (Foreign)
import Unsafe.Coerce(unsafeCoerce)
import Atom.Range
import Data.Function.Eff

foreign import data TextEditor :: *
foreign import data EDITOR :: !

foreign import getTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getLongTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getPath :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getText :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String


foreign import getTextInRangeImpl :: forall eff. TextEditor -> EffFn1 (editor :: EDITOR | eff) Range String

getTextInRange :: forall eff. TextEditor -> Range -> Eff (editor :: EDITOR | eff) String
getTextInRange = runEffFn1 <<< getTextInRangeImpl


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
