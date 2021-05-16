import Fluent
import Vapor

final class Dog: Model, Content {
    static let schema = "dogs"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "owner_id")
    var ownerId: UUID

    @Field(key: "breed_id")
    var breedId: UUID

    @Field(key: "name")
    var name: String

    init() { 
        // protocol 'Fields' requires initializer 'init()' with type '()'
    }

    init(id: UUID? = nil, ownerId: String, breedId: String, name: String) {
        self.id = id
        self.ownerId = UUID(uuidString: ownerId)!
        self.breedId = UUID(uuidString: breedId)!
        self.name = name
    }
}
