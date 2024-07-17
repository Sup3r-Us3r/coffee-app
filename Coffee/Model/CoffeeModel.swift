//
//  SwiftUIView.swift
//  Coffe
//
//  Created by Mayderson Mello on 03/07/24.
//

import SwiftUI

// MARK: Coffee Model With Sample Data
struct Coffee: Identifiable{
  var id: UUID = .init()
  var imageName: String
  var title: String
  var price: String
}

var coffees: [Coffee] = [
  .init(imageName: "3", title: "Iced\nMocha", price: "$9.20"),
  .init(imageName: "4", title: "Toffee\nCrunch Latte", price: "$12.30"),
  .init(imageName: "5", title: "Styled Cold\nCoffee", price: "$8.45"),
  .init(imageName: "12", title: "Vanilla\nLatte", price: "$23.10"),
  .init(imageName: "7", title: "Black Tea\nLatte", price: "$16.30"),
  .init(imageName: "9", title: "Hazelnut\nCappuccino", price: "$23.00"),
  .init(imageName: "2", title: "Caramel\nMacchiato", price: "$2.30"),
  .init(imageName: "10", title: "Mocha\nFrappuccino", price: "$15.00"),
  .init(imageName: "8", title: "Espresso\nCon Panna", price: "$25.00"),
  .init(imageName: "1", title: "Caramel\nCold Drink", price: "$3.90"),
  .init(imageName: "6", title: "Classic Irish\nCoffee", price: "$10.15"),
  .init(imageName: "11", title: "Café au\nLait", price: "$18.55"),
]
