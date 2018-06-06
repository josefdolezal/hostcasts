{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.CreateEpisode where

import Import
import Yesod.Form.Bootstrap3

createEpisodeForm :: AForm Handler Episode
createEpisodeForm = Episode
    <$> areq textField (attrs "Title") Nothing
    <*> areq textareaField (attrs "Description") Nothing
    where attrs placeholder = withPlaceholder placeholder (bfs ("" :: Text))

getCreateEpisodeR :: PodcastId -> Handler Html
getCreateEpisodeR podcastId = do
    (widget, _) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm createEpisodeForm
    defaultLayout $(widgetFile "episodes/new")

postCreateEpisodeR :: PodcastId -> Handler Html
postCreateEpisodeR podcastId = do
    ((result, widget), _) <- runFormPost $ renderBootstrap3 BootstrapBasicForm createEpisodeForm
    case result of
        FormSuccess episode -> do
            episodeId <- runDB $ insert episode
            redirect $ EpisodeR podcastId episodeId
        _ -> defaultLayout $(widgetFile "episodes/new")
