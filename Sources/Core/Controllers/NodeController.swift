//
//  NodeController.swift
//  
//
//  Created by Oleg Ivanchenko on 17.04.22.
//

import Vapor

struct NodeController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let nodes = routes.grouped("nodes")
        nodes.group(":nodeID") { node in
            node.get(use: get)
        }
    }
    
    func get(req: Request) async throws -> View {
        
        guard let nodeID = req.parameters.get("nodeID", as: Int.self) else {
            throw Abort(.badRequest, reason: "Empty node ID parameter")
        }

        guard let nodeData = try await NodeModel.find(nodeID, on: req.db) as NodeModel? else {
            throw Abort(.notFound)
        }

        return try await req.view.render("\(req.application.config.layoutDir)/page-node",
                                         ["title": nodeData.$title.value,
                                          "layout_dir": req.application.config.layoutDir,
                                          "top_menu": TopMenu.init().getHtml(),
                                          "body": nodeData.$body.value,
                                          "abstract": nodeData.$abstract.value])
    }
}
