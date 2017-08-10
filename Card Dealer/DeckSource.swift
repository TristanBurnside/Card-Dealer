//
//  NetworkDeckSource.swift
//  Card Dealer
//
//  Created by Tristan Burnside on 9/8/17.
//  Copyright © 2017 Tristan Burnside. All rights reserved.
//

import ReactiveSwift
import Alamofire

enum CardRetreivalError: Error {
  case network
  case outOfCards
}

protocol DeckSource {
  func getNextCard() -> SignalProducer<Card, CardRetreivalError>
  var numCardsRemaining: MutableProperty<Int> { get }
}

struct StaticDeckSource: DeckSource {
  
  let cards = [Card(suit:"", number:""), Card(suit:"2", number:"3")]
  
  func getNextCard() -> SignalProducer<Card, CardRetreivalError> {
    return SignalProducer.init(cards)
  }
  
  let numCardsRemaining: MutableProperty<Int> = MutableProperty(0)
}

struct NetworkDeckSource: DeckSource {
  let numCardsRemaining: MutableProperty<Int> = MutableProperty(0)
  
  func getNextCard() -> SignalProducer<Card, CardRetreivalError> {
    let cardProducer = SignalProducer() { (observer: Signal<Any, NSError>.Observer, lifetime) -> Void in
      let task = Alamofire.SessionManager.default.request(URL(string: "https://deckofcardsapi.com/api/deck/izi2w1jz4g0m/draw")!)
      task.responseJSON() { (response) in
        switch response.result {
        case .success(let json):
          observer.send(value: json)
        case .failure(let error):
          observer.send(error: error as NSError)
        }
      }
    }
    return cardProducer.map {
        return CardsResponse(json: $0)
      }.mapError { _ in
        return CardRetreivalError.network
      }.map { (response) -> Card? in
        return response?.cards.first
      }.flatMap(.concat) { (value: Card?) -> SignalProducer<Card, CardRetreivalError> in
        if let card = value {
          return SignalProducer(value: card)
        } else {
          return SignalProducer(error: .outOfCards)
        }
    }
  }
}
