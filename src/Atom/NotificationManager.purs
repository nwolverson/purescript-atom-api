module Atom.NotificationManager where

import Prelude (Unit)
import Control.Monad.Eff (Eff)

foreign import data NotificationManager :: *
foreign import data NOTIFY :: !

foreign import addSuccess :: forall eff. NotificationManager -> String -> Eff (note :: NOTIFY | eff) Unit
foreign import addInfo :: forall eff. NotificationManager -> String -> Eff (note :: NOTIFY | eff) Unit
foreign import addWarning :: forall eff. NotificationManager -> String -> Eff (note :: NOTIFY | eff) Unit
foreign import addError :: forall eff. NotificationManager -> String -> Eff (note :: NOTIFY | eff) Unit
foreign import addFatalError :: forall eff. NotificationManager -> String -> Eff (note :: NOTIFY | eff) Unit
