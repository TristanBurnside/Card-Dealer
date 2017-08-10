//
//  CardViewModelSpe.swift
//  Card Dealer
//
//  Created by Tristan Burnside on 10/8/17.
//  Copyright © 2017 Tristan Burnside. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift
@testable import Card_Dealer

struct TestDeckSource: DeckSource {
  func getNextCard() -> SignalProducer<Card, CardRetreivalError> {
    return SignalProducer.never
  }
  
  var numCardsRemaining: MutableProperty<Int> = MutableProperty(0)
}

class CardViewModelSpec: QuickSpec {
  override func spec() {
    describe("View Model") { 
      context("initial setup") {
        let viewModel = CardViewModel(dataSource: TestDeckSource())
        it("should have no cards") {
          expect(viewModel.numCardsRemaining.value).to(equal(0))
        }
      }
    }
  }
}
