{- This Source Code Form is subject to the terms of the Mozilla Public
 - License, v. 2.0. If a copy of the MPL was not distributed with this
 - file, You can obtain one at http://mozilla.org/MPL/2.0/.
 -}

{-# LANGUAGE CPP #-}

module GitHub.Data.Apps where

import Control.DeepSeq.Generics (genericRnf)
import Control.DeepSeq (NFData(..))
import Data.Binary (Binary)
import Data.Data (Data, Typeable)
import Data.Text (Text)
import Data.Time (UTCTime)
import GHC.Generics (Generic)
import GitHub.Data.Definitions (SimpleOwner)
import GitHub.Data.Id (Id)
import GitHub.Data.Name (Name)
import GitHub.Data.URL (URL)


data App = App
    { appId          :: !(Id App)
    , appOwner       :: !SimpleOwner
    , appName        :: !(Name App)
    , appDescription :: !(Maybe Text)
    , appExternalUrl :: !URL
    , appHtmlUrl     :: !URL
    , appCreatedAt   :: !(Maybe UTCTime)
    , appUpdatedAt   :: !(Maybe UTCTime)
    }
    deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData App where rnf = genericRnf
instance Binary App
