//
//  CardsView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 10.02.2025.
//


import SwiftUI
import FirestoreCollection

struct CardsView: View {
    
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
                    fetchFirstCards()
                }
            }
        }
        .navigationTitle("Cards")
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
            fetchFirstCards()
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
        .onAppear {
            checkIfItIsLastFetchedCard(card)
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
        Task {
            do {
                let card = Card(title: "Card_\(Int.random(in: 1...1000))")
                try cardsCollection.create(card)
                fetchFirstCards()
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
    
    func fetchFirstCards() {
        Task {
            do {
                // 1.
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextCards() {
        Task {
            do {
                // 2.
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkIfItIsLastFetchedCard(_ card: Card) {
        guard let lastCardId = cardsCollection.queryDocuments.last?.id, let cardId = card.id else {
            return
        }
        if lastCardId == cardId {
            self.fetchNextCards()
        }
    }
}

#Preview {
    CardsView()
}



