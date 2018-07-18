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

    var title: String

    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
