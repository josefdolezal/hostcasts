import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    try router.register("todo", controller: TodoController.self)
    try router.register("podcasts", controller: PodcastsController.self)
    try router.register(controller: HomeController.self)
}
