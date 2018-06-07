{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.PodcastAPI where

import Import

getPodcastAPIR :: PodcastId -> Handler RepXml
getPodcastAPIR podcastId = withUrlRenderer $ repXml $(widgetFile "xml-api/podcast")
