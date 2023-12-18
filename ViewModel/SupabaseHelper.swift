import Foundation
final class SupabaseHelper {
    static let baseURL = "https://yysvzirbkgoxlixxujkf.supabase.co"
    static let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs"

  
    // MARK: - Authentication
    static func signInAnonymously() async throws -> String {
        let url = URL(string: "\(baseURL)/auth/v1/token?grant_type=password")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": "", "password": ""]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let accessToken = json["access_token"] as? String {
            return accessToken
        } else {
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
    }

    static func signUp(email: String, password: String) async throws -> (String, String) {
        let url = URL(string: "\(baseURL)/auth/v1/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let accessToken = json["access_token"] as? String,
           let user = json["user"] as? [String: Any],
        let uid = user["id"] as? String {
            return (uid, accessToken)
        } else {
            throw NSError(domain: "[\(String(data: data, encoding: .utf8))]", code: -1, userInfo: nil)
        }
    }

    static func signIn(email: String, password: String) async throws -> (String, String) {
        let url = URL(string: "\(baseURL)/auth/v1/token?grant_type=password")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let accessToken = json["access_token"] as? String,
           let user = json["user"] as? [String: Any],
        let uid = user["id"] as? String {
            return (uid, accessToken)
        } else {
            throw NSError(domain: "[\(String(data: data, encoding: .utf8))]", code: -1, userInfo: nil)
        }
    }
    
    static func logout(token: String) async throws -> String {
        let url = URL(string: "\(baseURL)/auth/v1/logout")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
//        print(String(data: data, encoding: .utf8))
        return "loggedOut"
    }

  
    // MARK: - CRUD Operations
    
    static func create<T: Codable>(object: T, tableName: String) async throws {
        print(#function)
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(object)

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
    }

    static func read<T: Codable>(tableName: String) async throws -> [T] {
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    static func read<T: Codable>(tableName: String, column: String, value: String) async throws -> [T] {
        print(#function)
        let query = "\(column)=eq.\(value)"
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    static func read<T: Codable>(tableName: String, column: String, values: [String]) async throws -> [T] {
        let formattedValues: String = values.map { "\($0)" }.joined(separator: ",")
        print(formattedValues)
        let query = "\(column)=in.(\(formattedValues))"
        print(query)
        //let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    static func search<T: Codable>(tableName: String, column: String, searchText: String) async throws -> [T] {
        let queryValue = "%\(searchText)%"
        let query = "\(column)=ilike.\(percentEcode(queryValue))"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)?\(encodedQuery)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    private static func percentEcode(_ string: String) -> String {
        var allowedCharacters = CharacterSet.alphanumerics
        allowedCharacters.insert(charactersIn: "_%")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? string
    }

    static func update<T: Codable>(object: T, tableName: String, id: Int) async throws {
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)?id=eq.\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(object)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
    }

    static func delete(tableName: String, id: Int) async throws -> Void {
        let url = URL(string: "\(baseURL)/rest/v1/\(tableName)?id=eq.\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        _ = try await URLSession.shared.data(for: request)
    }

}
