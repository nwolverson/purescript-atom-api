module Atom.Editor (TextEditor, getTitle, getLongTitle, getPath, getText, getTextInRange, setTextInBufferRange, setTextInBufferRange', SetTextOptions, setText, getBuffer, toEditor, onDidSave, getCursorBufferPosition, module Atom.Types) where

import Prelude((<<<),Unit)
import Control.Monad.Eff(Eff)
import Data.Maybe (Maybe(..))
import Data.Foreign (Foreign)
import Unsafe.Coerce(unsafeCoerce)
import Atom.Range (Range)
import Data.Function.Eff (EffFn1, EffFn3, mkEffFn1, runEffFn1, runEffFn3)
import Atom.Point (Point)
import Atom.TextBuffer (TextBuffer)
import Atom.Types (EDITOR)

foreign import data TextEditor :: *

foreign import getTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getLongTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getPath :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getText :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String


foreign import getTextInRangeImpl :: forall eff. TextEditor -> EffFn1 (editor :: EDITOR | eff) Range String

getTextInRange :: forall eff. TextEditor -> Range -> Eff (editor :: EDITOR | eff) String
getTextInRange = runEffFn1 <<< getTextInRangeImpl

type SetTextOptions = { normalizeLineEndings :: Boolean, skipUndo :: Boolean }

foreign import setTextInBufferRangeImpl :: forall eff. TextEditor
  -> EffFn3 (editor :: EDITOR | eff) Range String { normalizeLineEndings :: Boolean, undo :: String } Range

setTextInBufferRange :: forall eff. TextEditor -> Range -> String -> Eff (editor :: EDITOR | eff) Range
setTextInBufferRange editor range text = setTextInBufferRange' editor range text
  { normalizeLineEndings: true, skipUndo: false} -- atom defaults

setTextInBufferRange' :: forall eff. TextEditor -> Range -> String -> SetTextOptions -> Eff (editor :: EDITOR | eff) Range
setTextInBufferRange' editor range text {normalizeLineEndings, skipUndo} =
  let undo = if skipUndo then "skip" else ""
  in runEffFn3 (setTextInBufferRangeImpl editor) range text { normalizeLineEndings, undo }

foreign import setTextImpl :: forall eff. TextEditor -> EffFn1 (editor :: EDITOR | eff) String Range

setText :: forall eff. TextEditor -> String -> Eff (editor :: EDITOR | eff) Range
setText = runEffFn1 <<< setTextImpl

foreign import onDidSaveImpl :: forall eff. TextEditor
  -> EffFn1 (editor :: EDITOR | eff) (EffFn1 (editor ::EDITOR | eff) { path :: String} Unit) Unit

onDidSave :: forall eff. TextEditor -> ({path :: String} -> Eff (editor :: EDITOR | eff) Unit)
  ->Eff (editor :: EDITOR | eff) Unit
onDidSave e f = runEffFn1 (onDidSaveImpl e) (mkEffFn1 f)


foreign import getCursorBufferPosition :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) Point


toEditor :: Foreign -> Maybe TextEditor
toEditor item =
  if isTextEditor item then
    Just (unsafeCoerce item)
  else
    Nothing

foreign import isTextEditor :: Foreign -> Boolean

foreign import getBuffer :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) TextBuffer
