//
//  CardDeckViewController.swift
//  Card Dealer
//
//  Created by Tristan Burnside on 9/8/17.
//  Copyright © 2017 Tristan Burnside. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class CardDeckViewController: UIViewController {

  let viewModel = CardViewModel(dataSource: NetworkDeckSource())
  
  @IBOutlet weak var shuffle: UIButton!
  
  override func viewDidLoad() {
    shuffle.reactive.controlEvents(.touchUpInside).producer.startWithValues { (_) in
      self.viewModel.getNextCard().map({ (card) -> CardView in
        return CardView(card: card)
      }).startWithResult({ (result) in
        switch result {
        case .success(let cardView):
          self.view.addSubview(cardView)
        default:
          return
        }
      })
    }
  }
  
}

class CardView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  init(card: Card) {
    super.init(frame: CGRect.zero)
    print("Added card \(card.suit), \(card.number)")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
