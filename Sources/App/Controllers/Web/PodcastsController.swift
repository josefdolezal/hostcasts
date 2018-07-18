//
//  PodcastsController.swift
//  App
//
//  Created by Josef Dolezal on 16/07/2018.
//

import Vapor

final class PodcastsController {
    func index(_ req: Request) throws -> Future<View> {
        let shows = Podcast.query(on: req).all()
        let title = "Podcasts"

        return try req.view().render("Home/index")
    }
}

extension PodcastsController: ControllerRouteCollection {
    func boot(router: Router) throws {
        router.get(use: index)
    }
}
