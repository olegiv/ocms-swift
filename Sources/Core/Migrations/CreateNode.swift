//
//  CreateNode.swift
//  
//
//  Created by Oleg Ivanchenko on 17.04.22.
//

import Fluent

extension NodeModel {
    struct CreateNode: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("nodes")
                .field("id", .int, .identifier(auto: true))
                .field("is_published", .bool, .required)
                .field("title", .string, .required)
                .field("body", .sql(raw: "TEXT"), .required)
                .field("abstract", .string)
                .field("alias", .string, .custom("UNIQUE"))
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("nodes").delete()
        }
    }
}
