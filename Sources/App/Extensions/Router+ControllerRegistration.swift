//
//  Router+ControllerRegistration.swift
//  App
//
//  Created by Josef Dolezal on 13/07/2018.
//

import Vapor

protocol ControllerRouteCollection: RouteCollection {
    init()
}

extension Router {
    func register<T: ControllerRouteCollection>(_ path: String, controller: T.Type) throws {
        let router = grouped(path)
        let collection = controller.init()

        try router.register(collection: collection)
    }
}
