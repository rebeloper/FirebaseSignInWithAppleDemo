//
//  AllCardsView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 16.02.2025.
//

import SwiftUI
import FirestoreCollection

struct AllCardsView: View {
    
    @State private var cardsCollection = FirestoreCollection<Card>(path: Path.Firestore.cards)
    
    var body: some View {
        Group {
            if cardsCollection.queryDocuments.isEmpty {
                ProgressView()
            } else {
                List {
                    ForEach(cardsCollection.queryDocuments) { card in
                        cell(for: card)
                    }
                }
                .refreshable {
                    fetchAllCards()
                }
            }
        }
        .navigationTitle("All Cards")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    createCard()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            fetchAllCards()
        }
    }
    
    func cell(for card: Card) -> some View {
        VStack(alignment: .leading) {
            Text(card.title)
            Text(card.createdDate, format: .dateTime)
                .font(.caption)
                .foregroundStyle(.secondary)
                .bold()
            Text(card.updatedDate, format: .dateTime)
                .font(.caption)
                .foregroundStyle(.secondary)
                .bold()
            Text(card.id ?? "No id")
                .font(.caption)
                .foregroundStyle(.secondary)
                .bold()
            Text(card.userId)
                .font(.caption)
                .foregroundStyle(.secondary)
                .bold()
        }
        .swipeActions(edge: .trailing) {
            Button {
                deleteCard(card)
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        .swipeActions(edge: .leading) {
            Button {
                updateCard(card)
            } label: {
                Image(systemName: "pencil")
            }
        }
    }
    
    func createCard() {
        do {
            let card = Card(title: "Card_\(Int.random(in: 1...1000))")
            try cardsCollection.create(card)
            fetchAllCards()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllCards() {
        Task {
            do {
                try await cardsCollection.fetchAll(predicates: [.orderBy("createdAt", true)])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCard(_ card: Card) {
        Task {
            do {
                var updatedCard = card
                updatedCard.title = "Card_\(Int.random(in: 1000...2000))"
                try await cardsCollection.update(with: updatedCard)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCard(_ card: Card) {
        Task {
            do {
                try await cardsCollection.delete(card)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    CardsView()
}


