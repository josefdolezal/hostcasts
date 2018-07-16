//
//  ShowsController.swift
//  App
//
//  Created by Josef Dolezal on 16/07/2018.
//

import Vapor

final class ShowsController {
    func index(_ req: Request) throws -> Future<View> {
        let shows = Show.query(on: req).all()
        let title = "Shows"

        return try req.view().render("Home/index")
    }
}

extension ShowsController: ControllerRouteCollection {
    func boot(router: Router) throws {
        router.get(use: index)
    }
}
