//
//  OrderForDeliveryView.swift
//  FoodDeliveryApp
//
//  Created by Nasser Faris on 03/06/1445 AH.
//

import SwiftUI
import UIKit
import AVFoundation
import AVKit

class SounManager{
    static let instance = SounManager()
    var player: AVAudioPlayer?

     func playSound() {
        guard let url = Bundle.main.url(forResource: "attentions", withExtension: "mp3") else { return }

        do {

            player = try AVAudioPlayer(contentsOf: url)

            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}


struct OrderForDeliveryView: View {
    @StateObject var orderVM = OrderViewModel()
    @StateObject var deliveredVM = DeliveryOrderedViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isAccept: Bool = false
    let date = Date()
    func formatDateToString(_date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
  
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Orders List")
                    .font(.title2)
                    .foregroundColor(.orange2)
                    .bold()
                   // .underline()
                ScrollView{
                    if orderVM.orders.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(orderVM.orders.indices, id:\.self){ index in
                            NavigationLink {
                                DetailsOrderView(restaurent: orderVM.orders[index].restaurant, meal: orderVM.orders[index].meal_name, userName: orderVM.orders[index].user_name, mobile: orderVM.orders[index].mobile, price: orderVM.orders[index].price, latitude: orderVM.orders[index].latitude , longitude: orderVM.orders[index].longitude)
                            } label: {
                                VStack{
                                  
                                    RoundedRectangle(cornerRadius: 8*2)
                                        .stroke(Color.gray)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 200)
                                        .overlay{
                                            VStack{
                                                HStack{
                                                    Text("New Order")
                                                        .font(.title2)
                                                        .bold()
                                                    
                                                    Image("attention")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 8*2.5 , height: 8*2.5)
                                                } .padding(.bottom)
                                                VStack(alignment: .leading){
                                                    
                                                    HStack {
                                                        Text("From :")
                                                            .bold()
                                                        Text(" \(orderVM.orders[index].restaurant)")
                                                    }
                                                    HStack {
                                                        Text("To :")
                                                            .bold()
                                                        Text(" \(orderVM.orders[index].user_name)")
                                                    }
                                                    HStack {
                                                        Text("Total Price :")
                                                            .bold()
                                                        Text(" \(orderVM.orders[index].price) SR")
                                                    }
                                                    
                                                }.padding(.bottom)
                                                    .frame(maxWidth: .infinity , alignment: .leading)
                                                    .padding(.leading)
                                           
                                                HStack(spacing: 90){
                                                    Button(action: {
                                                        deliveredVM.addDelivery(id: UUID(),
                                                                                restaurant: orderVM.orders[index].restaurant,
                                                                                meal: orderVM.orders[index].meal_name,
                                                                                userName: orderVM.orders[index].user_name,
                                                                                price: orderVM.orders[index].price,
                                                                                date: formatDateToString(_date: date),
                                                                                deliverd: true)
                                                        isAccept.toggle()
                                                    }, label: {
                                                   
                                                        CustomButton(text: "Accept")
                                                    })
                                                    
                                                    Button(action: {
                                                        orderVM.deleteOrder(id: (orderVM.orders[index].id?.uuidString)!)
                                                    }, label: {
                                                        CustomButton(text: "Reject")
                                                    })
                                                }.padding(.horizontal)
                                            }
                                            
                                        }
                                    
                                }.foregroundColor(.black)
                                    .padding(.horizontal)
                                    .onAppear {
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            SounManager.instance.playSound()
                                        }
                                    }
                            }
                        }
                    }
                }
                
            }.padding()
        } .navigationBarItems(leading:
                                Button(action: {
            
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        })
        )
    }
}

#Preview {
    OrderForDeliveryView()
}
/*
 var body: some View {
     NavigationStack {
         VStack {
             Text("Orders List")
                 .font(.title2)
                 .foregroundColor(.orange2)
                 .bold()

             ScrollView {
                 if orderVM.orders.isEmpty {
                     ProgressView()
                 } else {
                     ForEach(orderVM.orders.indices, id: \.self) { index in
                         NavigationLink {
                             DetailsOrderView(
                                 restaurent: orderVM.orders[index].restaurant,
                                 meal: orderVM.orders[index].meal_name,
                                 userName: orderVM.orders[index].user_name,
                                 mobile: orderVM.orders[index].mobile,
                                 price: orderVM.orders[index].price,
                                 latitude: orderVM.orders[index].latitude,
                                 longitude: orderVM.orders[index].longitude
                             )
                         } label: {
                             OrderRowView(order: orderVM.orders[index], isAccepted: orderVM.acceptedOrders.contains(orderVM.orders[index].id?.uuidString ?? ""))
                                 .animation(.easeInOut)
                                 .onAppear {
                                     DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                                         SounManager.instance.playSound()
                                     }
                                 }
                         }
                     }
                 }
             }
         }
         .padding()
     }
 }

 struct OrderRowView: View {
     let order: OrderModel
     let isAccepted: Bool
     @State private var isAccept: Bool = false

     var body: some View {
         VStack {
             RoundedRectangle(cornerRadius: 8 * 2)
                 .stroke(Color.gray)
                 .frame(maxWidth: .infinity)
                 .frame(height: 200)
                 .overlay {
                     VStack {
                         // Your existing code

                         HStack(spacing: 90) {
                             Button(action: {
                                
                             }, label: {
                                 CustomButton(text: "Accept")
                             })

                             Button(action: {
                                 // Your existing code
                             }, label: {
                                 CustomButton(text: "Reject")
                             })
                         }
                     }
              
          }.foregroundColor(.black)
            .padding(.horizontal)
            .onAppear {
     
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             SounManager.instance.playSound()
         }
     }
}
     }
 }

 */
