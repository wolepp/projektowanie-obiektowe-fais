import Fluent
import Vapor

struct BreedController: RouteCollection {

    static let path = "breeds"

    func boot(routes: RoutesBuilder) throws {
        // routing made in routes.swift
    }

    func list(req: Request) throws -> EventLoopFuture<View> {
        let allBreeds = Breed.query(on: req.db).all()
        return allBreeds.flatMap { breeds in 
            let data = ["breedList": breeds]
            return req.view.render("breeds", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let breed = try req.content.decode(Breed.self)
        return breed.save(on: req.db).map { _ in 
            return req.redirect(to: "/" + BreedController.path)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Breed.self)
        return Breed.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { breed in
                breed.id = input.id
                breed.name = input.name
                breed.color = input.color
                return breed.save(on: req.db).map { _ in
                    return req.redirect(to: "/" + BreedController.path)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Breed.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/" + BreedController.path)
            }
    }
}
