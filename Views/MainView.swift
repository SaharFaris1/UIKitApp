
import SwiftUI

struct MainView: View {
    var body: some View {
        @Environment(\.presentationMode) var presentationMode
        NavigationStack{
            TabView{
                
                PreviousOrderView()
                    .tabItem {
                        Label(" ", systemImage: "checklist.checked")
                    } 
                
                
                OrderForDeliveryView()
                    .tabItem {
                        Label(" ", systemImage: "car.rear.waves.up")
                    }
                
                ProfileIView()
                    .tabItem {
                        Label(" ", systemImage: "person")
                    }
            }  }.navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

#Preview {
    MainView()
}
