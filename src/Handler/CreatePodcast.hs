{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.CreatePodcast where

import Import
import Yesod.Form.Bootstrap3
import qualified Forms.PodcastsForms as PF

createPodcastForm :: AForm Handler Podcast
createPodcastForm = Podcast
    <$> areq textField (attrs "Title") Nothing
    <*> areq textareaField (attrs "Description") Nothing
    <*> aopt textField (attrs "URL") Nothing
    where attrs placeholder = withPlaceholder placeholder (bfs ("" :: Text))

getCreatePodcastR :: Handler Html
getCreatePodcastR = do
    (widget, _) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm createPodcastForm
    defaultLayout $(widgetFile "podcasts/new")

postCreatePodcastR :: Handler Html
postCreatePodcastR = do
    ((result, widget), _) <- runFormPost $ renderBootstrap3 BootstrapBasicForm createPodcastForm
    case result of
        FormSuccess podcast -> do
            podcastId <- runDB $ insert podcast
            redirect (PodcastR podcastId)
        _ -> defaultLayout $(widgetFile "podcasts/new")

