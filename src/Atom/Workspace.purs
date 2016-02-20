module Atom.Workspace (Workspace, WORKSPACE, observeTextEditors, onDidChangeActivePaneItem, getActiveTextEditor) where

import Prelude
import Control.Monad.Eff
import Atom.Editor
import Data.Foreign (Foreign)
import Data.Function.Eff
import Data.Maybe(Maybe)

foreign import data Workspace :: *
foreign import data WORKSPACE :: !

foreign import observeTextEditorsImpl :: forall eff. Workspace
  -> EffFn1 eff (EffFn1 eff TextEditor Unit) Unit

-- should this have EDITOR? Don't think so
observeTextEditors :: forall eff. Workspace -> (TextEditor -> Eff (workspace :: WORKSPACE | eff) Unit)
  -> Eff (workspace :: WORKSPACE | eff) Unit
observeTextEditors w f = runEffFn1 (observeTextEditorsImpl w) (mkEffFn1 f)

foreign import onDidChangeActivePaneItemImpl :: forall eff. Workspace
  -> EffFn1 eff (EffFn1 eff Foreign Unit) Unit

onDidChangeActivePaneItem :: forall eff. Workspace -> (Foreign -> Eff (workspace :: WORKSPACE | eff) Unit)
  -> Eff (workspace :: WORKSPACE | eff) Unit
onDidChangeActivePaneItem w f = runEffFn1 (onDidChangeActivePaneItemImpl w) (mkEffFn1 f)

foreign import getActiveTextEditorImpl :: forall eff. Workspace
  -> Eff (workspace :: WORKSPACE | eff) Foreign

getActiveTextEditor :: forall eff. Workspace
  -> Eff (workspace :: WORKSPACE | eff) (Maybe TextEditor)
getActiveTextEditor w = toEditor <$> getActiveTextEditorImpl w
