//
//  Podcast.swift
//  App
//
//  Created by Josef Dolezal on 16/07/2018.
//

import Vapor
import FluentSQLite

final class Podcast: SQLiteModel {
    var id: Int?
    var userId: Int
    var imageId: Int?

    var title: String
    var copyright: String?
    var url: URL?
    var keywords: String?
    var isExplicit: Bool
    var publishDate: Date
    var description: String
    var updateDate: Date

    init(id: Int? = nil, userId: Int, imageId: Int?, title: String, copyright: String?, url: URL?, keywords: String?, isExplicit: Bool, publishDate: Date, description: String, updateDate: Date = Date()) {
        self.id = id
        self.userId = userId
        self.imageId = imageId

        self.title = title
        self.copyright = copyright
        self.url = url
        self.keywords = keywords
        self.isExplicit = isExplicit
        self.publishDate = publishDate
        self.description = description
        self.updateDate = updateDate
    }
}

extension Podcast {
    var episodes: Children<Podcast, Episode> {
        return children(\.podcastId)
    }

    var image: Children<Podcast, PodcastImage> {
        return children(\.id)
    }
}
