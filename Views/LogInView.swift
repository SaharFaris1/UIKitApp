//
//  LogInView.swift
//  FoodDeliveryApp
//
//  Created by Nasser Faris on 03/06/1445 AH.
//

import SwiftUI
struct LogInView: View {
    @StateObject var loginVM = LogInViewModel()
    @State var email: String = ""
    @State var id: String = ""
    @State var showText: Bool = false
    @State private var isLoggedIn: Bool = false
    @State var checkEntry:String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            ScrollView{
                HeaderView()
                
                VStack {
                    Text("Login")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                    
                    VStack(spacing: 35){
                 TextField("Email", text: $loginVM.email)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.orange2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                            .font(.title2)
                         
                      SecureField("Password", text: $loginVM.password)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.orange2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                            .font(.title2)
                            
                    }.onSubmit {
                        if let uuid = UUID(uuidString: id), !uuid.uuidString.isEmpty {
                            //  loginVM.loginEmployee(id: uuid, email: email)
                            loginVM.login()
                            isLoggedIn = true
                            
                        } else {
                            print("Invalid UUID input")
                        }
                    }
                    
                    
                    if (loginVM.email == "" || loginVM.password == ""){
                        Text("Enter The ID and Email To Continue")
                            .padding()
                        
                    }else{
                        NavigationLink(
                            destination: MainView(),
                            isActive: $isLoggedIn,
                            label: {
                                Text("Log In")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.orange2))
                                    .padding()
                            }
                        )
                    }
                        
                    
                    
                    
                }
                .padding()
                .foregroundColor(.orange2)
                    .padding()
                    .disabled(loginVM.networking)
            }.ignoresSafeArea()
        }.navigationBarItems(leading:
                                Button(action: {
            
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        })
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LogInView()
}

// to check if user exist or need to sign up
/*
 class LogInViewModel: ObservableObject {
 // ... your existing code ...
 
 func checkUserExists(id: UUID, email: String, completion: @escaping (Bool) -> Void) {
 // Perform a Supabase query to check if the user already exists
 // This will depend on your Supabase setup and API
 // Assume you have a function like checkUserExists in your Supabase API
 
 // Replace the following line with your actual Supabase API call
 supabaseAPI.checkUserExists(id: id, email: email) { exists in
 completion(exists)
 }
 }
 }
 
 struct LogInView: View {
 @StateObject var loginVM = LogInViewModel()
 @State var email: String = ""
 @State var id: String = ""
 @State private var isLoggedIn: Bool = false
 @State private var isNewUser: Bool = false
 
 var body: some View {
 NavigationStack {
 VStack(spacing: 30.0) {
 // ... your existing code ...
 
 VStack {
 // ... your existing code ...
 
 }.onSubmit {
 if let uuid = UUID(uuidString: id), !uuid.uuidString.isEmpty {
 // Check if the user exists in Supabase
 loginVM.checkUserExists(id: uuid, email: email) { exists in
 if exists {
 // User exists, proceed with login
 loginVM.loginEmployee(id: uuid, email: email)
 isLoggedIn = true
 } else {
 // User is new, show a message or take appropriate action
 isNewUser = true
 }
 }
 } else {
 print("Invalid UUID input")
 }
 }
 
 NavigationLink(
 destination: isNewUser ? SignUpView() : MainView(),
 isActive: $isLoggedIn,
 label: {
 Text("Log In")
 .font(.title2)
 .foregroundColor(.white)
 .frame(maxWidth: .infinity)
 .frame(height: 50)
 .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.orange2))
 }
 )
 
 Spacer()
 }
 .foregroundColor(.orange2)
 .padding()
 }
 }
 }
 
 */
