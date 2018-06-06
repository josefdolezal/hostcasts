{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Podcasts where

import Import
import Repository.PodcastsRepository as PR

getPodcastsR :: Handler Html
getPodcastsR = do
    podcasts <- PR.allPodcasts
    defaultLayout $(widgetFile "podcasts/podcasts")
