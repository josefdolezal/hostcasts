{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.PodcastAPI where

import Import
import Text.XML
import Text.Hamlet
import Text.Hamlet.XML
import qualified Data.Map as M

getPodcastAPIR :: PodcastId -> Handler RepXml
getPodcastAPIR podcastId = return $ RepXml $ toContent $ renderText def $ itunesRssDoc $(xmlFile "templates/xml-api/podcast.hamlet")

itunesRssDoc :: [Node] -> Document
itunesRssDoc nodes = xmlDoc "rss" attributes nodes
    where attributes = [ mkAttribute "version" "2.0"
                       , mkAttribute "xmlns:atom" "http://www.w3.org/2005/Atom"
                       , mkAttribute "xmlns:itunes" "http://www.itunes.com/dtds/podcast-1.0.dtd"
                       , mkAttribute "xmlns:itunesu" "http://www.itunesu.com/feed"
                       ]

xmlDoc :: String -> [(Name, Text)] -> [Node] -> Document
xmlDoc root attrs nodes = Document prologue (Element (fromString root) (M.fromList attrs) nodes) []
    where prologue = Prologue [] Nothing []

mkAttribute :: Text -> Text -> (Name, Text)
mkAttribute name text = (mkName name, text)

mkName :: Text -> Name
mkName t = Name t Nothing Nothing