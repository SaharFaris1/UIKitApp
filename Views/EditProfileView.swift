
import SwiftUI

struct EditProfileView: View {
    @StateObject var vmP = ProfileViewModel()
    @State var editname: String = ""
    @State var isActive: Bool = false
    @State var isSheetPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack{
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
                                            .fill(Color.orange)
                                            .frame(width: 70, height: 70)
                                    )
                                
                                Text(profile.name)
                                    .font(.title)
                                    .bold()
                                    .padding()
                                
                                HStack{
                                    Text("Name:")
                                        .font(.title2).bold()
                                    Text("\(profile.name)")
                                    
                                        .font(.title2)
                                    Spacer()
                                    Button(action: {
                                        isSheetPresented.toggle()
                                    }) {
                                        Image(systemName: "square.and.pencil.circle")
                                            .font(.largeTitle)
                                            .foregroundStyle(Color.orange2)
                                    }.sheet(isPresented: $isSheetPresented) {
                                        VStack{
                                            Text("Edit Profile")
                                                .font(.title)
                                                .bold()
                                            TextField("Edit Name", text: $editname)
                                                .bold()
                                                .foregroundColor(.orange2)
                                                .padding()
                                            Button {
                                                vmP.editProfile(name: editname)
                                                
                                                isSheetPresented.toggle()
                                            } label: {
                                                Text("Save")
                                                    .font(.title)
                                                    .foregroundStyle(Color.orange2)
                                            }
                                        }}
                                    
                                }.padding()
                                Divider()
                                
                                
                                HStack(spacing:15){
                                    Text("Email Address :")
                                        .font(.title2).bold()
                                    Text(profile.email)
                                        .font(.title3)
                                }
                                Divider()
                                HStack(spacing: 50){
                                    Text("Phone Number :")
                                        .font(.title2).bold()
                                    Text(profile.phoneNum)
                                        .font(.title3)
                                }.padding()
                                
                            }.padding()
                        }
                        
                        
                    }
                }.ignoresSafeArea()
            }
           
            .onAppear {
                vmP.fetchProfile()
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
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
    EditProfileView()
}
