//
//  APIService.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import Foundation

class APIService {
    // Setting up a singleton: 
    static let shared = APIService()
    
    // Enum for Error handling:
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw APIError.error("Error: Invalid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid HTTP Response Code")
                throw APIError.error("Error: Invalid HTTP Response Code")
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            print("Error: \(decodingError.localizedDescription)")
            throw APIError.error("Error: \(decodingError.localizedDescription)")
        } catch let urlError as URLError {
            print("Error: \(urlError.localizedDescription)")
            throw APIError.error("Error: \(urlError.localizedDescription)")
        } catch {
            print("Unknown Error: \(error.localizedDescription)")
            throw APIError.error("Unknown Error: \(error.localizedDescription)")
        }
    }
}
