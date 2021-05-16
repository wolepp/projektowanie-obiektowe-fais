import Fluent
import Vapor

final class Breed: Model, Content {
    static let schema = "breeds"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "color")
    var color: String

    init() { 
        // protocol 'Fields' requires initializer 'init()' with type '()'
    }

    init(id: UUID? = nil, name: String, color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
}
