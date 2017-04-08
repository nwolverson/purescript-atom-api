module Atom.CommandRegistry (addCommand, addCommand', dispatch, dispatchRoot, CommandRegistry, COMMAND) where

import Control.Monad.Eff (Eff)
import DOM.HTML.Types (HTMLElement)
import DOM.Node.Types (Element, Node)
import Data.Function.Eff (EffFn1, EffFn2, EffFn3, mkEffFn1, runEffFn1, runEffFn2, runEffFn3)
import Prelude (Unit)

foreign import data CommandRegistry :: *
foreign import data COMMAND :: !

foreign import addImpl :: forall eff a. CommandRegistry ->
  EffFn3 (command :: COMMAND | eff) a String (EffFn1 (command :: COMMAND | eff) Unit Unit) Unit

addCommand :: forall eff. CommandRegistry -> String -> String -> (Unit -> Eff (command :: COMMAND | eff) Unit)
  -> Eff (command :: COMMAND | eff) Unit
addCommand cr selector commandName callback =
  runEffFn3 (addImpl cr) selector commandName (mkEffFn1 callback)


addCommand' :: forall eff. CommandRegistry -> Element -> String -> (Unit -> Eff (command :: COMMAND | eff) Unit)
  -> Eff (command :: COMMAND | eff) Unit
addCommand' cr elt commandName callback =
  runEffFn3 (addImpl cr) elt commandName (mkEffFn1 callback)

-- findCommands(params)

dispatch :: forall eff. CommandRegistry -> Node -> String -> Eff (command :: COMMAND | eff) Unit
dispatch cr = runEffFn2 (dispatchImpl cr)

foreign import dispatchImpl :: forall eff a. CommandRegistry ->
  EffFn2 (command :: COMMAND | eff) a String Unit


dispatchRoot :: forall eff. CommandRegistry -> String -> Eff (command :: COMMAND | eff) Unit
dispatchRoot cr = runEffFn1 (dispatchRootImpl cr)

foreign import dispatchRootImpl :: forall eff. CommandRegistry ->
  EffFn1 (command :: COMMAND | eff) String Unit

-- onWillDispatch(callback)

-- onDidDispatch(callback)
