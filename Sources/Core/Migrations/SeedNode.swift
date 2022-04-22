//
//  SeedNode.swift
//  
//
//  Created by Oleg Ivanchenko on 17.04.22.
//

import FluentKit

extension NodeModel {
    
    struct SeedNode: Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {

          let nodes: [NodeModel] = [
              .init(
                isPublished: true,
                title: "Download OCMS",
                body: """
    <h2>Download the latest release from Github</h2><ul><li><a href='https://github.com/olegiv/ocms-swift/releases/latest' target='_blank'>Download source code</a></li><li><a href='https://github.com/olegiv/ocms-swift/releases' target='_blank'>Changelog</a></li><li><a href='https://github.com/olegiv/ocms-swift/blob/master/LICENSE.txt' target='_blank'>License</a></li></ul><h2>Previous releases</h2><p>For previous releases, visit the <a href='https://github.com/olegiv/ocms-swift/releases' target='_blank'>Github release page</a>.</p>
    """,
                abstract: "Get started by downloading and building OCMS. These official releases come bundled with modules and themes to give you a good starting point to help build your site.",
                alias: "/download",
                createdAt: nil,
                updatedAt: nil
              ),
              
              .init(
                isPublished: true,
                title: "About OCMS",
                body: "<h3>Welcome to About page!</h3>",
                abstract: "This is About OCMS page.",
                alias: "/about",
                createdAt: nil,
                updatedAt: nil
              ),
              
              .init(
                isPublished: true,
                title: "Blog",
                body: "<h3>Welcome to OCMS Blog!</h3>",
                alias: "/blog"
              )
        ]
            
        return nodes.map { node in
          node.save(on: database)
        }
        .flatten(on: database.eventLoop)
      }

      func revert(on database: Database) -> EventLoopFuture<Void> {
        NodeModel.query(on: database).delete()
      }
    }
}
