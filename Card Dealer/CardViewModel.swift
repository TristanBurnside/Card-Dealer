//
//  CardViewModel.swift
//  Card Dealer
//
//  Created by Tristan Burnside on 9/8/17.
//  Copyright © 2017 Tristan Burnside. All rights reserved.
//

import ReactiveSwift

struct CardViewModel {
  private let deckSource: MutableProperty<DeckSource>
  let numCardsRemaining = MutableProperty(0)
  
  init(dataSource: DeckSource) {
    deckSource = MutableProperty(dataSource)
    numCardsRemaining <~ deckSource.producer.flatMap(FlattenStrategy.latest) { (source) -> MutableProperty<Int> in
      return source.numCardsRemaining
    }
  }
  
  func getNextCard() -> SignalProducer<Card, CardRetreivalError> {
    return deckSource.value.getNextCard()
  }
  
}
