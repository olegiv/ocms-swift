//
//  Node.swift
//  
//
//  Created by Oleg Ivanchenko on 17.04.22.
//

import Fluent
import Vapor

final class NodeModel: Model, Content, @unchecked Sendable {
    
    static let schema = "nodes"
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    @Field(key: "is_published")
    var isPublished: Bool

    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Field(key: "abstract")
    var abstract: String?
    
    @Field(key: "alias")
    var alias: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: Int? = nil, isPublished: Bool, title: String, body: String, abstract: String? = "", alias: String, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.isPublished = isPublished
        self.title = title
        self.body = body
        self.abstract = abstract
        self.alias = alias
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
