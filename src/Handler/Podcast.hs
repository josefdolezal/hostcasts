{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.Podcast where

import Import

getPodcastR :: PodcastId -> Handler Html
getPodcastR podcastId = do
    podcast <- runDB $ get404 podcastId
    defaultLayout $(widgetFile "podcasts/podcast")
