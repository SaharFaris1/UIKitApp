
import SwiftUI

struct SignupView: View {
    @StateObject var vmm = AuthenticationViewModel()
    @State var name:String = ""
    @State var email:String = ""
    @State var isActive: Bool = false
    @State var password:String = ""
    @State var showText: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    HeaderView()
                    VStack(spacing: 30){
                        Text("Create New Account")
                            .font(.title)
                            .bold()
                        
                        HStack{
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                    .frame(width: 35, height: 35)
                                
                                TextField("Full Name", text: $name)
                            }.padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.orange2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                        
                 
                        
                        HStack{
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .frame(width: 35, height: 35)
                            
                            TextField("Email", text: $email)
                            
                            
                            
                        }.padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.orange2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                         
                        HStack{
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                            if showText {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                            Button(action: {
                                showText.toggle()
                            }) {
                                Image(systemName: showText ? "eye.fill" : "eye.slash.fill")
                                    .foregroundColor(.gray)
                            }
                        } .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.orange2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                       
                        Button(action: {
                            vmm.signUp(email: email, password: password)
                            isActive = true
                        }) {
                            Text("Register")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 330, height: 55)
                                .background(Color.orange2)
                                .cornerRadius(20)
                        }.fullScreenCover(isPresented:$isActive ) {
                       PreviousOrderView()
                        }
                        .padding()
                        HStack{
                            Text("already have an account?")
                            NavigationLink(
                                destination: LogInView(),
                        
                                label: {
                                    Text("Log In")
                            
                                        .foregroundColor(.orange1)
                                        
                                }
                            )                        }
                        
                    }.padding()
                }.ignoresSafeArea()
                
            }
        }            .navigationBarItems(leading:
                                            Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    })
                    )

    }}
#Preview {
    SignupView()
}
