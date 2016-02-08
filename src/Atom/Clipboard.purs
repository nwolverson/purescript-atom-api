module Atom.Clipboard where

import Prelude (Unit)
import Control.Monad.Eff (Eff)

foreign import data Clipboard    :: *
foreign import data ClipboardEff :: * -> !

foreign import read  :: forall a e. Clipboard -> Eff (clipboardEff :: ClipboardEff a | e) String

foreign import readWithMetadata :: forall a e. Clipboard -> Eff (clipboardEff :: ClipboardEff a | e) {text :: String, metadata :: a}

foreign import write :: forall a e. Clipboard -> String -> a -> Eff (clipboardEff :: ClipboardEff a | e) Unit
