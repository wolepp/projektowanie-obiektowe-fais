import Fluent

struct CreateOwner: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("owners")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("owners").delete()
    }
}
