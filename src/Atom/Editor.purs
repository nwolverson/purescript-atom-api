module Atom.Editor (TextEditor, getTitle, getLongTitle, getPath, getText, getTextInRange, getSelectedText,
  setTextInBufferRange, setTextInBufferRange', SetTextOptions, setText, insertText,
  getBuffer, toEditor, onDidSave,
  getCursorBufferPosition, moveToTop, moveToBottom, moveUp, moveDown, moveToBeginningOfLine,
  module Atom.Types, setGrammar) where

import Prelude
import Atom.Grammar (Grammar)
import Atom.Point (Point)
import Atom.Range (Range)
import Atom.TextBuffer (TextBuffer)
import Atom.Types (EDITOR)
import Control.Monad.Eff (Eff)
import Data.Either (either)
import Data.Foreign (readString, Foreign)
import Data.Function.Eff (EffFn1, EffFn3, mkEffFn1, runEffFn1, runEffFn3)
import Data.Maybe (Maybe(..))
import Unsafe.Coerce (unsafeCoerce)

foreign import data TextEditor :: *

foreign import getTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getLongTitle :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getPathImpl :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) Foreign

getPath :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) (Maybe String)
getPath editor = do
  res <- readString <$> getPathImpl editor
  pure $ either (const Nothing) Just res

foreign import getText :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

foreign import getSelectedText :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) String

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

-- really returns Boolean|Range...
foreign import insertTextImpl :: forall eff. TextEditor -> EffFn1 (editor :: EDITOR | eff) String Unit

insertText :: forall eff. TextEditor -> String -> Eff (editor :: EDITOR | eff) Unit
insertText = runEffFn1 <<< insertTextImpl



foreign import onDidSaveImpl :: forall eff. TextEditor
  -> EffFn1 (editor :: EDITOR | eff) (EffFn1 (editor ::EDITOR | eff) { path :: String} Unit) Unit

onDidSave :: forall eff. TextEditor -> ({path :: String} -> Eff (editor :: EDITOR | eff) Unit)
  ->Eff (editor :: EDITOR | eff) Unit
onDidSave e f = runEffFn1 (onDidSaveImpl e) (mkEffFn1 f)


foreign import getCursorBufferPosition :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) Point

foreign import moveToTop :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) Unit

foreign import moveToBottom :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) Unit


foreign import moveUpImpl :: forall eff. TextEditor -> EffFn1 (editor :: EDITOR | eff) Int Unit

moveUp :: forall eff. TextEditor -> Int -> Eff (editor :: EDITOR | eff) Unit
moveUp = runEffFn1 <<< moveUpImpl

foreign import moveDownImpl :: forall eff. TextEditor ->  EffFn1 (editor :: EDITOR | eff) Int Unit
moveDown :: forall eff. TextEditor -> Int -> Eff (editor :: EDITOR | eff) Unit
moveDown = runEffFn1 <<< moveDownImpl

foreign import moveToBeginningOfLine :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) Unit


toEditor :: Foreign -> Maybe TextEditor
toEditor item =
  if isTextEditor item then
    Just (unsafeCoerce item)
  else
    Nothing

foreign import isTextEditor :: Foreign -> Boolean

foreign import getBuffer :: forall eff. TextEditor -> Eff (editor :: EDITOR | eff) TextBuffer

foreign import setGrammar :: forall eff. TextEditor -> Grammar -> Eff (editor :: EDITOR | eff) Unit
