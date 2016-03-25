module Atom.Workspace (Workspace, WORKSPACE, observeTextEditors, onDidChangeActivePaneItem, getActiveTextEditor, addModalPanel, Panel, destroyPanel) where

import Prelude (Unit, (<$>))
import Control.Monad.Eff (Eff)
import Atom.Editor (TextEditor, toEditor)
import Data.Foreign (Foreign)
import Data.Function.Eff (EffFn1, mkEffFn1, runEffFn1)
import Data.Maybe(Maybe)
import DOM.Node.Types

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

addModalPanel :: forall eff. Workspace -> Element -> Boolean -> Int
  -> Eff (workspace :: WORKSPACE | eff) Panel
addModalPanel w item visible priority = runEffFn1 (addModalPanelImpl w) {item, visible, priority}

foreign import addModalPanelImpl :: forall eff. Workspace ->
  EffFn1 (workspace :: WORKSPACE | eff)  { item :: Element, visible :: Boolean, priority :: Int  } Panel

-- TODO move
foreign import data Panel :: *

foreign import destroyPanel :: forall eff. Panel -> Eff (workspace::WORKSPACE | eff) Unit

-- TODO TODO TODO
-- foreign import getModel
