{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.CreatePodcast where

import Import
import Yesod.Form.Bootstrap3
import qualified Forms.PodcastsForms as PF

createPodcastForm :: UserId -> AForm Handler Podcast
createPodcastForm userId = Podcast
    <$> areq textField (attrs "Title") Nothing
    <*> areq textareaField (attrs "Description") Nothing
    <*> areq (selectFieldList [("English" :: Text, "en-us")]) "Language" Nothing
    <*> aopt textField (attrs "Tags") Nothing
    <*> aopt textField (attrs "Copyright notice") Nothing
    <*> areq checkBoxField (attrs "Is Explicite") Nothing
    <*> aopt textField (attrs "URL") Nothing
    <*> aopt textField (attrs "Cover") Nothing
    <*> pure userId
    where attrs placeholder = withPlaceholder placeholder (bfs ("" :: Text))

getCreatePodcastR :: Handler Html
getCreatePodcastR = do
    userId <- requireAuthId
    (widget, _) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm (createPodcastForm userId)
    defaultLayout $(widgetFile "podcasts/new")

postCreatePodcastR :: Handler Html
postCreatePodcastR = do
    userId <- requireAuthId
    ((result, widget), _) <- runFormPost $ renderBootstrap3 BootstrapBasicForm (createPodcastForm userId)
    case result of
        FormSuccess podcast -> do
            podcastId <- runDB $ insert podcast
            redirect (PodcastR podcastId)
        _ -> defaultLayout $(widgetFile "podcasts/new")

