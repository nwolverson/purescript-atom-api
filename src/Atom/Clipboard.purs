module Atom.Clipboard where

import Control.Monad.Eff

foreign import data Clipboard    :: *
foreign import data ClipboardEff :: * -> !

foreign import read
  "function read(c) {\
  \  return function () {\
  \    return c.read();\
  \  }\
  \}" :: forall a e. Clipboard -> Eff (clipboardEff :: ClipboardEff a | e) String

foreign import readWithMetadata
  "function readWithMetadata(c) {\
  \  return function () {\
  \    return c.readWithMetadata();\
  \  }\
  \}" :: forall a e. Clipboard -> Eff (clipboardEff :: ClipboardEff a | e) {text :: String, metadata :: a}

foreign import write
  "function write(c) {\
  \  return function (t) {\
  \    return function (m) {\
  \      return function () {\
  \        c.write(t, m);\
  \      }\
  \    }\
  \  }\
  \}" :: forall a e. Clipboard -> String -> a -> Eff (clipboardEff :: ClipboardEff a | e) Unit
