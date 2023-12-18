import Foundation
import SwiftUI

class AuthenticationViewModel: ObservableObject{
    @Published var user: AuthModel?
    func signUp(email: String, password: String){
        let parameters = "{\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\"\n}"
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/auth/v1/signup")!,timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        
        
    }
}
