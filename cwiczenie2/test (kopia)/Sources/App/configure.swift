import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateBreed())
    app.migrations.add(CreateOwner())
    app.migrations.add(CreateDog())

    app.views.use(.leaf)

    

    // register routes
    try routes(app)
}
