//
//  myCardsPresneter.swift
//  myCards
//
//  Created by Mohamed Ali on 05/12/2023.
//

import Foundation

protocol myCardsProtocol: NSObject {
    func fetchCardsSuccessfully(cards: [CardModel])
    func makeButtonEnabled(card: CardModel?)
}

class myCardsPresneter {
    weak var viewDelegate: myCardsProtocol?
    var cards = Array<CardModel>()
    
    init(viewDelegate: myCardsProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    
    /// This funtion will be used to fetch Cards from API Services.
    func fetchCardsOperation() {
        cards = [
                        CardModel(cardTitle: "Abdullah Ghatasheh",
                                  cardNumber: "**** 2312",
                                  cardBalance: 2354,
                                  backgroundColor: "#E6DDFF",
                                  last: false
                                 ),
                        CardModel(cardTitle: "Abdullah Ghatasheh",
                                  cardNumber: "**** 5432",
                                  cardBalance: 1350,
                                  backgroundColor: "#6F45E9",
                                  last: false
                                 ),
                        CardModel(cardTitle: "Zyad Khorbatshoph",
                                  cardNumber: "**** 3245",
                                  cardBalance: 2140,
                                  backgroundColor: "#270685",
                                  last: true
                                 )
                    ]
        
        viewDelegate?.fetchCardsSuccessfully(cards: cards)
    }
    
    func cardSelectedOperation(index: Int,selected: Bool) {
        if selected {
            viewDelegate?.makeButtonEnabled(card: cards[index])
        }
        else {
            viewDelegate?.makeButtonEnabled(card: nil)
        }
    }
}
