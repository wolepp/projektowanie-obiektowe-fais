import Fluent
import Vapor

final class Dog: Model, Content {
    static let schema = "dogs"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "owner_id")
    var owner_id: UUID

    @Field(key: "breed_id")
    var breed_id: UUID

    @Field(key: "name")
    var name: String

    init() { 
        // protocol 'Fields' requires initializer 'init()' with type '()'
    }

    init(id: UUID? = nil, owner_id: String, breed_id: String, name: String) {
        self.id = id
        self.owner_id = UUID(uuidString: owner_id)!
        self.breed_id = UUID(uuidString: breed_id)!
        self.name = name
    }
}
