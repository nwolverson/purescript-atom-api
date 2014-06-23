module Atom.ContextMenuManager where

foreign import data ContextMenuManager :: *
foreign import data ContextMenu        :: *
foreign import data Event              :: *

type ContextMenuOptions = forall r. { devMode :: Boolean | r }

foreign import add
  "function add(c) {\
  \  return function (name) {\
  \    return function (object) {\
  \      return function (options) {\
  \        return function () {\
  \          c.add(name, object, options);\
  \        }\
  \      }\
  \    }\
  \  }\
  \}" :: forall e. ContextMenuManager -> String -> ContextMenu -> Eff e Unit

foreign import showForEvent
 "function showForEvent(c) {\
  \  return function (event) {\
  \    return function () {\
  \      \
  \    }\
  \  }\
  \}" :: forall e. ContextMenuManager -> Event -> Eff e Unit
