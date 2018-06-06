{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Podcast where

import Import

getPodcastR :: PodcastId -> Handler Html
getPodcastR podcastId = do
    podcast <- runDB $ get404 podcastId
    episodes <- runDB $ selectList [] [Asc EpisodeId]
    defaultLayout $(widgetFile "podcasts/podcast")
