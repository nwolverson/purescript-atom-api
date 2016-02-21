module Atom.Config (getConfig, setConfig, Config, CONFIG) where

import Prelude (Unit, (<<<))
import Control.Monad.Eff (Eff)
import Data.Function.Eff (EffFn2, EffFn1, runEffFn2, runEffFn1)
import Data.Foreign (Foreign)

foreign import data Config :: *
foreign import data CONFIG :: !

foreign import getConfigImpl :: forall eff. Config -> EffFn1 (config :: CONFIG | eff) String Foreign

getConfig :: forall eff. Config -> String -> Eff (config :: CONFIG | eff) Foreign
getConfig = runEffFn1 <<< getConfigImpl

foreign import setConfigImpl :: forall eff. Config -> EffFn2 (config :: CONFIG | eff) String Foreign Unit

setConfig :: forall eff. Config -> String -> Foreign -> Eff (config :: CONFIG | eff) Unit
setConfig = runEffFn2 <<< setConfigImpl
