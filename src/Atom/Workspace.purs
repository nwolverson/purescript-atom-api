module Atom.Workspace (Workspace, WORKSPACE,
  observeTextEditors, onDidChangeActivePaneItem, getActiveTextEditor, addModalPanel,
  Panel, destroyPanel, open, OpenOptions, defaultOpenOptions, getActivePane, addOpener, paneForURI, paneForItem) where

import Prelude
import DOM.Node.Types (Element)
import Atom.Editor (TextEditor, toEditor)
import Atom.Pane (Pane)
import Control.Monad.Eff (Eff)
import Data.Foreign (Foreign)
import Data.Function.Eff (EffFn1, runEffFn4, EffFn4, mkEffFn1, runEffFn1)
import Data.Maybe (Maybe)
import Data.Nullable (toMaybe, Nullable)

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

defaultOpenOptions :: OpenOptions
defaultOpenOptions =
  { initialLine: 0
  , initialColumn: 0
  , split: "left"
  , activatePane: true
  , activateItem: true
  , pending: false
  , searchAllPanes: false
  }
type OpenOptions =
  { initialLine :: Int
  , initialColumn :: Int
  , split :: String
  , activatePane :: Boolean
  , activateItem :: Boolean
  , pending :: Boolean
  , searchAllPanes :: Boolean
  }

foreign import openImpl :: forall eff. Workspace
  -> EffFn4 (workspace :: WORKSPACE | eff)
      String
      OpenOptions
      (EffFn1 (workspace :: WORKSPACE | eff) TextEditor Unit)
      (Eff (workspace :: WORKSPACE | eff) Unit)
      Unit

open :: forall eff. Workspace -> String -> OpenOptions ->
  (TextEditor -> Eff (workspace :: WORKSPACE | eff) Unit) ->
  (Eff (workspace :: WORKSPACE | eff) Unit) ->
  Eff (workspace :: WORKSPACE | eff) Unit
open w s o cb err = runEffFn4 (openImpl w) s o (mkEffFn1 cb) err

foreign import getActivePane :: forall eff. Workspace -> Eff (workspace :: WORKSPACE | eff) Pane

foreign import addOpenerImpl :: forall eff. Workspace -> EffFn1 (workspace :: WORKSPACE | eff)
  (EffFn1 (workspace :: WORKSPACE | eff) String Element)
  Pane

addOpener :: forall eff. Workspace ->
  (String -> Eff (workspace :: WORKSPACE | eff) Element) ->
  (Eff (workspace :: WORKSPACE | eff) Pane)
addOpener w f = runEffFn1 (addOpenerImpl w) (mkEffFn1 f)

foreign import paneForURIImpl ::  forall eff. Workspace -> EffFn1 (workspace :: WORKSPACE | eff) String (Nullable Pane)

paneForURI ::  forall eff. Workspace -> String -> Eff (workspace :: WORKSPACE | eff) (Maybe Pane)
paneForURI w uri = toMaybe <$> runEffFn1 (paneForURIImpl w) uri

foreign import paneForItemImpl ::  forall eff a. Workspace -> EffFn1 (workspace :: WORKSPACE | eff) a (Nullable Pane)

paneForItem ::  forall eff a. Workspace -> a -> Eff (workspace :: WORKSPACE | eff) (Maybe Pane)
paneForItem w a = toMaybe <$> runEffFn1 (paneForItemImpl w) a
