import Fluent
import Vapor

struct DogController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func list(req: Request) throws -> EventLoopFuture<View> {
        let allDogs = Dog.query(on: req.db).all()
        return allDogs.flatMap { dogs in 
            let data = ["dogList": dogs]
            return req.view.render("dogs", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let dog = try req.content.decode(Dog.self)
        return dog.save(on: req.db).map { _ in 
            return req.redirect(to: "/dogs")
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Dog.self)
        return Dog.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { dog in
                dog.id = input.id
                dog.owner_id = input.owner_id
                dog.breed_id = input.breed_id
                dog.name = input.name
                return dog.save(on: req.db).map { _ in
                    return req.redirect(to: "/dogs")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Dog.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/dogs")
            }
    }
}
