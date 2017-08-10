//
//  Card.swift
//  Card Dealer
//
//  Created by Tristan Burnside on 9/8/17.
//  Copyright © 2017 Tristan Burnside. All rights reserved.
//

import ReactiveSwift

struct Card {
  let suit: String
  let number: String
}

extension Card {
  init?(json: Any) {
    guard let json = json as? [String: Any] else {
      return nil
    }
    suit = json["suit"] as! String
    number = json["value"] as! String
  }
}

struct CardsResponse {
  let remaining: Int
  let cards: [Card]
  
  init?(json: Any) {
    guard let json = json as? [String: Any],
      let remaining = json["remaining"] as? Int,
      let cardsJson = json["cards"] as? [Any] else {
      return nil
    }
    self.remaining = remaining
    cards = cardsJson.flatMap{ Card(json: $0) }
  }
}
