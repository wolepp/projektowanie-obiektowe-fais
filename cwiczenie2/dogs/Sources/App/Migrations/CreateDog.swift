import Fluent

struct CreateDog: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("dogs")
            .id()
            .field("name", .string, .required)
            .field("owner_id", .uuid, .required, .references("owners", "id"))
            .foreignKey("owner_id", references: "owners", "id", onDelete: .cascade)
            .field("breed_id", .uuid, .required, .references("breeds", "id"))
            .foreignKey("breed_id", references: "breeds", "id", onDelete: .cascade)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("dogs").delete()
    }
}
