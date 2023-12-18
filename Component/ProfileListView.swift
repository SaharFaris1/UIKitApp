import SwiftUI
struct ProfileListView: View {
    @StateObject var prof = ProfileDatabase()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            VStack {
                ForEach(prof.profiledatabase) { pr in
                    NavigationLink(destination: pr.destination) {
                      HStack {
                            Image(systemName: pr.proImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.orange2)
                                        .frame(width: 40, height: 40)
                                )
                            Text(pr.proText)
                                .font(.title3)
                                .foregroundStyle(Color.black)
                                .padding()
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }.padding()
                        
                    }
                    Divider()
                } .foregroundColor(.black)
                
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




struct HelpCenterView: View {
    var body: some View {
        Text("Help Center View")
    }
}


struct TermsConditionView: View {
    var body: some View {
        Text("Terms & Condition View")
    }
}



#Preview {
    ProfileListView()
}
