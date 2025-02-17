//
//  Card.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 13.02.2025.
//

import SwiftUI
@preconcurrency import FirebaseFirestore
import FirestoreCollection

struct Card: Firestorable {
    
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    var userId: String = ""
    
    var createdDate: Date {
        createdAt?.dateValue() ?? Date()
    }
    
    var updatedDate: Date {
        updatedAt?.dateValue() ?? Date()
    }
    
    var title: String
    
    init(title: String = "") {
        self.title = title
    }
    
    enum CodingKeys: CodingKey {
        case id
        case createdAt
        case updatedAt
        case userId
        case title
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(DocumentID<String>.self, forKey: .id)
        self._createdAt = try container.decodeIfPresent(ServerTimestamp<Timestamp>.self, forKey: .createdAt) ?? ServerTimestamp(wrappedValue: Timestamp(date: .now))
        self._updatedAt = try container.decodeIfPresent(ServerTimestamp<Timestamp>.self, forKey: .updatedAt) ?? ServerTimestamp(wrappedValue: Timestamp(date: .now))
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self._id, forKey: .id)
        try container.encodeIfPresent(self._createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self._updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.title, forKey: .title)
    }
}
