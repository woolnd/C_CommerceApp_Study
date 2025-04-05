//
//  NetworkService.swift
//  Cproject
//
//  Created by wodnd on 4/4/25.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case responseError
    case decodeError
    case serverError(statusCode: Int)
    case unknownError
}

class NetworkService {
    static let shared: NetworkService = NetworkService()
    
    private let hostURL: String = "https://my-json-server.typicode.com/JeaSungLEE/JsonAPIFastCampus"
    
    private func createdURL(withPath path: String) throws -> URL {
        let urlString = "\(hostURL)\(path)"
        guard let url = URL(string: urlString) else { throw NetworkError.urlError}
        
        return url
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.responseError }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    func getHomeData() async throws -> HomeResponse{
        let url = try createdURL(withPath: "/db")
        let data = try await fetchData(from: url)
        
        do {
            let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.decodeError
        }
    }
}
