//
//  CardSpec.swift
//  Card Dealer
//
//  Created by Tristan Burnside on 9/8/17.
//  Copyright © 2017 Tristan Burnside. All rights reserved.
//

import Quick
import Nimble
@testable import Card_Dealer

class CardSpec: QuickSpec {
  override func spec() {
    describe("Tests of the card model") { 
      context("a card is created") {
        let card = Card(suit: "clubs", number: "9")
        it("should have a suit") {
          expect(card.suit).to(equal("clubs"))
        }
      }
    }
  }
}
