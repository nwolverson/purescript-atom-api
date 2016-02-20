module Atom.CommandRegistry (addCommand, CommandRegistry, COMMAND) where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Data.Function.Eff (EffFn1, EffFn3, mkEffFn1, runEffFn3)

foreign import data CommandRegistry :: *
foreign import data COMMAND :: !

foreign import addImpl :: forall eff. CommandRegistry ->
  EffFn3 (command :: COMMAND | eff) String String (EffFn1 (command :: COMMAND | eff) Unit Unit) Unit

addCommand :: forall eff. CommandRegistry -> String -> String -> (Unit -> Eff (command :: COMMAND | eff) Unit)
  -> Eff (command :: COMMAND | eff) Unit
addCommand cr selector commandName callback =
  runEffFn3 (addImpl cr) selector commandName (mkEffFn1 callback)

-- findCommands(params)

-- dispatch(target, commandName)

-- onWillDispatch(callback)

-- onDidDispatch(callback)
