import Fluent

struct CreateBreed: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("breeds")
            .id()
            .field("name", .string, .required)
            .field("color", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("breeds").delete()
    }
}
