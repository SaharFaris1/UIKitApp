
import Foundation



class LogInViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var gender: String = "Male"
    
    @Published var networking: Bool = false
    
    
    @MainActor
    func login() {
        Task {
            do {
                networking = true
                let (uid, token) = try await SupabaseHelper.signIn(email: email, password: password)
                
           //     let result: [User] = try await SupabaseHelper.read(tableName: "User", column: "uid", value: uid)
                
                AuthService.shared.token = token
            //    AuthService.shared.user = result.first
                AuthService.shared.loggedIn = true
                networking = false
            } catch {
                networking = false
                print(error)
            }
            
        }
    }
    
    @MainActor
    func guest() {
        Task {
            do {
                //let token = try await SupabaseHelper.signInAnonymously()
                //AuthService.shared.token = token
                AuthService.shared.loggedIn = true
            } catch {
                print(error)
            }
            
        }
    }
}

    
  /*
    @Published var employee: [LogInModel] = []
    
    init(){
        fetch()
       // loginEmployee(id: UUID(), email: "")
    }
    
    
    func fetch(){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/Employee?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NzY2NzIsImV4cCI6MjAxODE1MjY3Mn0.yd1I3jBjrIKUp6AAQYCqc-SSEty_Q624gpmqhx46LcU", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NzY2NzIsImV4cCI6MjAxODE1MjY3Mn0.yd1I3jBjrIKUp6AAQYCqc-SSEty_Q624gpmqhx46LcU", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let data = data {
                       do {
                           let decoder = JSONDecoder()
                           let employees = try decoder.decode([LogInModel].self, from: data)

                           // Update your view model with the fetched data
                           DispatchQueue.main.async {
                               self.employee = employees
                           }
                       } catch {
                           print("Error decoding JSON: \(error)")
                       }
                   }
        }

        task.resume()

    }
    
    
  //-----------------------------------------------//
    
    func loginEmployee(id: UUID , email: String){
      let tempRaw = LogInModel(id: id, email: email)
        DispatchQueue.main.async {
           self.employee.append(tempRaw)
       }
        
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/Employee")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NzY2NzIsImV4cCI6MjAxODE1MjY3Mn0.yd1I3jBjrIKUp6AAQYCqc-SSEty_Q624gpmqhx46LcU", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NzY2NzIsImV4cCI6MjAxODE1MjY3Mn0.yd1I3jBjrIKUp6AAQYCqc-SSEty_Q624gpmqhx46LcU", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

   
        do {
               let encoder = JSONEncoder()
               let jsonData = try encoder.encode(tempRaw)
               request.httpBody = jsonData
           } catch {
               print("Error encoding employee data: \(error)")
               return
           }


        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Did not receive a valid HTTP response")
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                print("New row added successfully with status code: \(httpResponse.statusCode)")
            } else {
                print("Failed to add new row with status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
  
    }
        */
     
    
//}
