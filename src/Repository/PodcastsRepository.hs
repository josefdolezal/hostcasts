module Repository.PodcastsRepository where

import Import

allPodcasts :: Handler [Entity Podcast]
allPodcasts = runDB $ selectList [] [Asc PodcastId]
