import Vapor
import Fluent

func routes(_ app: Application) throws {

    try app.register(collection: HomepageController())
    try app.register(collection: NodeController())
    
    // Aliases
    app.get("**") { req -> View in
        
        let alias = req.url.path
        
        guard let node = try await NodeModel.query(on: req.db).filter(\.$alias == alias).first() else {
            throw Abort(.notFound, reason: "Sorry, you tried to access a page that does not exist or was moved")
        }
        
        return try await req.view.render("\(req.application.config.layoutDir)/page-node",
                                         ["title": node.$title.value,
                                          "layout_dir": req.application.config.layoutDir,
                                          "top_menu": TopMenu.init().getHtml(),
                                          "body": node.$body.value,
                                          "abstract": node.$abstract.value])
    }
}
