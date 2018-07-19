//
//  Episode.swift
//  App
//
//  Created by Josef Dolezal on 18/07/2018.
//

import Vapor
import FluentSQLite

final class Episode: SQLiteModel {
    var id: Int?
    var podcastId: Int

    var title: String
    var description: String
    var subtitle: String?
    var category: String
    var media: File
    var publishDate: Date?

    init(id: Int? = nil, podcastId: Int, title: String, description: String, subtitle: String?, category: String, media: File, publishDate: Date?) {
        self.id = id
        self.podcastId = podcastId

        self.title = title
        self.description = description
        self.subtitle = subtitle
        self.category = category
        self.media = media
        self.publishDate = publishDate
    }
}

extension Episode {
    var podcast: Parent<Episode, Podcast> {
        return parent(\.podcastId)
    }
}
