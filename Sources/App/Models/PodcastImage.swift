//
//  PodcastImage.swift
//  App
//
//  Created by Josef Dolezal on 19/07/2018.
//

import Vapor
import FluentSQLite

final class PodcastImage: SQLiteModel {
    var id: Int?

    var link: URL?
    var title: String?

    init(id: Int? = nil, link: URL?, title: String?) {
        self.id = id
        self.link = link
        self.title = title
    }
}
