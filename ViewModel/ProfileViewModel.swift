
import Foundation
class ProfileViewModel: ObservableObject{
    @Published var profile: [ProfileModel] = []
    init(){
        fetchProfile()
        
    }
    
    func fetchProfile(){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/EmployeeInfo?id=eq.1")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "Authorization")
        
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
            
            if let data = data,
               let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                print("")
                
                let  decoder = JSONDecoder()
                do{
                    self.profile = try decoder.decode([ProfileModel].self, from: data)
                    print(self.profile)
                    print("")
                }
                catch{
                    print("error\(error)")
                }
                
            }
            
        }
        task.resume()
    }
    
    func editProfile(name: String) {
        let parameters = """
            {
                "name": "\(name)"
            }
            """
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/EmployeeInfo?id=eq.1")!,timeoutInterval: Double.infinity)
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("return=minimal", forHTTPHeaderField: "Prefer")
        
        request.httpMethod = "PATCH"
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
