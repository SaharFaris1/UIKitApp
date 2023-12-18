//
//  DeliveryOrderModel.swift
//  FoodDeliveryApp
//
//  Created by Nasser Faris on 03/06/1445 AH.
//

import Foundation
struct DeliveryOrderModel: Identifiable , Codable{
    let id: UUID?
    let restaurant: String
    let meal: String
    let userName: String
    let price: Int
    let date: String
    let deliverd: Bool?
}
