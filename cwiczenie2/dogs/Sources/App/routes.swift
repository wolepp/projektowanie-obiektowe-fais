import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.get { req in
        return req.view.render("index", ["title": "Dogs!"])
    }

    let dogController = DogController()

    app.get("dogs", use: dogController.list)

    app.post("dog", "create", use: dogController.create)
    app.post("dog", "update", ":id", use: dogController.update)
    app.post("dog", "delete", ":id", use: dogController.delete)



    let ownerController = OwnerController()

    app.get("owners", use: ownerController.list)

    app.post("owner", "create", use: ownerController.create)
    app.post("owner", "update", ":id", use: ownerController.update)
    app.post("owner", "delete", ":id", use: ownerController.delete)



    let breedController = BreedController()

    app.get("breeds", use: breedController.list)

    app.post("breed", "create", use: breedController.create)
    app.post("breed", "update", ":id", use: breedController.update)
    app.post("breed", "delete", ":id", use: breedController.delete)
}
