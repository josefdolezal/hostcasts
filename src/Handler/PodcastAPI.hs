{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.PodcastAPI where

import Import
import Text.XML
import Text.Hamlet

getPodcastAPIR :: PodcastId -> Handler RepXml
getPodcastAPIR podcastId = repXml <$> toContent <$> withUrlRenderer $(hamletFile "templates/xml-api/podcast.hamlet")
