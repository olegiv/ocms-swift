import Fluent
//import FluentMySQLDriver
import FluentSQLiteDriver
import Leaf
import Vapor
import LeafErrorMiddleware

// configures your application
public func configure(_ app: Application) throws {
    
    app.config = .init(layoutDir: Environment.get("LAYOUT") ?? "core/light")
    
    // Errors
    app.middleware.use(LeafErrorMiddlewareDefaultGenerator.build())
    
    // Static files
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // Database (MySQL || MariaDB)
    /*var tls = TLSConfiguration.makeClientConfiguration()
    tls.certificateVerification = .none
    app.databases.use(.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tlsConfiguration: tls
    ), as: .mysql)*/

    // SQLite    
    app.databases.use(.sqlite(.file("Resources/DB/db.sqlite")), as: .sqlite)

    // Migrations
    app.migrations.add(NodeModel.CreateNode())
    app.migrations.add(NodeModel.SeedNode())

    // Views
    app.views.use(.leaf)    

    // Routes
    try routes(app)
}
