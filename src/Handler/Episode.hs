{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Episode where

import Import

getEpisodeR :: PodcastId -> EpisodeId -> Handler Html
getEpisodeR podcastId episodeId = do
    episode <- runDB $ get404 episodeId
    defaultLayout $(widgetFile "episodes/episode")
