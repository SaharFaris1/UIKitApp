
import Foundation

class DeliveryOrderedViewModel: ObservableObject{
    @Published var deliverd: [DeliveryOrderModel] = []
    
    let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs"
    
    
    init(){
        fetch()
    }
    
    func fetch() {
       
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/PreviousOrders?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set your headers here
        request.setValue(key, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
       
      
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
                    let deliverdData = try decoder.decode([DeliveryOrderModel].self, from: data)
                      
                 
                    DispatchQueue.main.async {
                        self.deliverd = deliverdData
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        task.resume()
      
    }
    //-----------------------------------------------//
    func addDelivery(id: UUID? , restaurant: String, meal: String , userName: String,price: Int , date: String ,  deliverd: Bool  ){
        
        let tempRaw = DeliveryOrderModel(id: id, restaurant: restaurant, meal: meal, userName: userName, price: price, date: date, deliverd: deliverd)
          DispatchQueue.main.async {
             self.deliverd.append(tempRaw)
         }
          
          let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/PreviousOrders")!
          var request = URLRequest(url: url)
          request.httpMethod = "POST"

          // Set your headers here
          request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
          request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "Authorization")
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

     
          do {
                 let encoder = JSONEncoder()
                 let jsonData = try encoder.encode(tempRaw)
                 request.httpBody = jsonData
             } catch {
                 print("Error encoding data: \(error)")
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
   //--------------------------------------------------------------//
    

    
}
