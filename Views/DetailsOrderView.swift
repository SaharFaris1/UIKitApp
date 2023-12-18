
import SwiftUI
import UIKit

struct DetailsOrderView: View {
    var restaurent: String
    var meal: String
    var userName: String
    var mobile: String
    var price: Int
    var latitude: Double
    var longitude: Double
    
    
    var body: some View {
        VStack{
            Text("Order Details")
                .font(.title2)
                .bold()
                .foregroundColor(.orange2)
            ScrollView{
                VStack(alignment: .leading ,spacing: 10){
                    Text("Order Location:")
                        .bold()
                    MapView(latitude: latitude, longitude: longitude)
                        .frame(height: 300)
                    Button("Open in Google Maps") {
                        openInGoogleMaps()
                        }
                          .foregroundColor(.blue)
                        //  .padding()
                    
                    HStack{
                        Text("From Restaurent :")
                            .bold()
                        Text(restaurent)
                    }
                    Divider()
                        .frame(width: 350)
                    HStack{
                        Text("To Client Name :")
                            .bold()
                        Text(userName)
                    }
                    Divider()
                        .frame(width: 350)
                    HStack{
                        Text("Mobile :")
                            .bold()
                        Button(action: {
                            let telephone = "tel://"
                            let formattedString = telephone + mobile
                            guard let url = URL(string: formattedString) else { return }
                               UIApplication.shared.open(url)
                            }) {
                            Text(mobile)
                       }
                    }
                    Divider()
                        .frame(width: 350)
                    HStack{
                            
                        Button(action: {
                            openWhatsApp()
                            }) {
                                HStack{
                                    Image(systemName: "phone.bubble.left")
                                    Text("WhatsApp")
                                }
                        }
                    }
                    Divider()
                        .frame(width: 350)
                    HStack{
                        Text("Total Price: ")
                            .bold()
                        Text("\(price) SR")
                    }
                    
                }.frame(maxWidth: .infinity , alignment: .leading)
                    .padding()
                
            }
        }
    }
    
    func openInGoogleMaps() {
    //    let googleMapsURLString = "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving"
        let googleMapsURLString = "https://www.google.co.in/maps/dir/??saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving"
        guard let googleMapsURL = URL(string: googleMapsURLString) else {
            print("Invalid Google Maps URL.")
            return
        }

        if UIApplication.shared.canOpenURL(googleMapsURL) {
            UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(
                title: "Google Maps Not Installed",
                message: "Please install Google Maps to navigate to the destination.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            if let topController = UIApplication.shared.windows.first?.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
    func openWhatsApp(){
        let whatsappUrl = URL(string: "https://api.whasapp.com/sen?phone=\(mobile)&text=Hola")!
        if UIApplication.shared.canOpenURL(whatsappUrl){
            UIApplication.shared.open(whatsappUrl)
        }else{
            print("WhatsApp Not Installed")
        }
    }


    }

#Preview {
    DetailsOrderView(restaurent: "", meal: "", userName: "", mobile: "", price: 0 , latitude: 0.0 , longitude: 0.0)
}
