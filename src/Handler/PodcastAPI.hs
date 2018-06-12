{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.PodcastAPI where

import Import
import Text.XML
import Text.Hamlet
import qualified Data.Map as M

getPodcastAPIR :: PodcastId -> Handler RepXml
getPodcastAPIR podcastId = do
    podcast <- runDB $ get404 podcastId
    episodes <- runDB $ selectList [] [Desc EpisodeId]
    repXml <$> withUrlRenderer $(hamletFile "templates/xml-api/podcast.hamlet")
