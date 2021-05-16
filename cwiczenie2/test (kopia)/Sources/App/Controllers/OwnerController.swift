import Fluent
import Vapor

struct OwnerController: RouteCollection {

    static let path = "/owners"

    func boot(routes: RoutesBuilder) throws {
        // routing made in routes.swift
    }

    func list(req: Request) throws -> EventLoopFuture<View> {
        let allOwners = Owner.query(on: req.db).all()
        return allOwners.flatMap { owners in 
            let data = ["ownerList": owners]
            return req.view.render("owners", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let owner = try req.content.decode(Owner.self)
        return owner.save(on: req.db).map { _ in 
            return req.redirect(to: "/owners")
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Owner.self)
        return Owner.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { owner in
                owner.id = input.id
                owner.name = input.name
                return owner.save(on: req.db).map { _ in
                    return req.redirect(to: "/owners")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Owner.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/owners")
            }
    }
}
