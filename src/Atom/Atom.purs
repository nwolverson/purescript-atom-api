module Atom.Atom where

import Control.Monad.Eff (Eff)

import Atom.Clipboard (Clipboard)
import Atom.CommandRegistry (CommandRegistry)
import Atom.Config (Config)
import Atom.NotificationManager (NotificationManager)
import Atom.Project (Project)
import Atom.Workspace (Workspace)
import Atom.GrammarRegistry (GrammarRegistry)

data Mode
  = Editor
  | Spec

type Atom =
  { clipboard :: Clipboard
  , notifications :: NotificationManager
  , commands :: CommandRegistry
  , config :: Config
  , project :: Project
  , workspace :: Workspace
  , grammars :: GrammarRegistry
  }

foreign import getAtom :: forall e. Eff e Atom
