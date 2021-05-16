import Fluent
import Vapor

final class Owner: Model, Content {
    static let schema = "owners"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    init() { 
        // protocol 'Fields' requires initializer 'init()' with type '()'
    }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
