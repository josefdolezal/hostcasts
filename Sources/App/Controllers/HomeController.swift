//
//  HomeController.swift
//  App
//
//  Created by Josef Dolezal on 15/07/2018.
//

import Vapor

final class HomeController {
    func index(_ req: Request) throws -> Future<View> {
        return try req.view().render("Home/index")
    }
}

extension HomeController: ControllerRouteCollection {
    func boot(router: Router) throws {
        router.get(use: index)
    }
}
