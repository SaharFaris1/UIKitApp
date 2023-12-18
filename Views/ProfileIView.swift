import SwiftUI

struct ProfileIView: View {
    @StateObject var vmP = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
        ScrollView {
            HeaderView()
             VStack {
                        ForEach(vmP.profile) { profile in
                            VStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 30)
                                    .foregroundColor(.white)
                                    .background(
                                        Circle()
                                            .fill(Color.orange2)
                                            .frame(width: 70, height: 70)
                                    )
                                    .padding()
                                
                                
                                    Text(profile.name)
                                        .font(.title)
                                        .bold()
                        
                            
                                
                            }
                            
                         
                          
                    }
            ProfileListView()
                   
                }
            }    .ignoresSafeArea()

           
        }
    }
}

#Preview {
    ProfileIView()
}

