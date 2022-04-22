//
//  HomepageController.swift
//  
//
//  Created by Oleg Ivanchenko on 18.04.22.
//

import Vapor

struct HomepageController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        
        routes.get { req async throws -> View in
            return try await req.view.render("\(req.application.config.layoutDir)/page-homepage",
                                   ["title": "Homepage",
                                    "layout_dir": req.application.config.layoutDir,
                                    "top_menu": TopMenu.init().getHtml()])
        }
    }
}
