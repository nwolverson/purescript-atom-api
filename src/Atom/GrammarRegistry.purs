module Atom.GrammarRegistry where

import Control.Monad.Eff (Eff)
import Atom.Grammar (GRAMMAR, Grammar)

foreign import data GrammarRegistry :: Type

foreign import getGrammars :: forall eff. GrammarRegistry -> Eff (grammar :: GRAMMAR | eff) Grammar

foreign import grammarForScopeName :: forall eff. GrammarRegistry -> String -> Eff (grammar :: GRAMMAR | eff) Grammar
