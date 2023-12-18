//
//  OrderModel.swift
//  FoodDeliveryApp
//
//  Created by Nasser Faris on 03/06/1445 AH.
//

import Foundation

struct OrderModel: Identifiable , Codable{
    let id: UUID?
    let price: Int
    let meal: UUID?
    let user: UUID?
    let user_name: String
    let restaurant: String
    let meal_name: String
    let mobile: String
    let latitude: Double
    let longitude: Double
}
