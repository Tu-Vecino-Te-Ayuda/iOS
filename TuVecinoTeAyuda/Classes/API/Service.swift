//
//  Service.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import Foundation

protocol ServiceType {
    typealias ServiceCompletionHandler<T: Decodable> = (Result<T, APIError>) -> Void
    func login(parameters: [String: String], completionHandler: @escaping ServiceCompletionHandler<LoginResponse>)
}

enum APIError: Error {
    case statusCode(Int)
    case unknownResponse
    case apiError(Error)
    case malformedRequestUrl
}

final class Service: ServiceType {
    
    // MARK: - Private properties
    
    private let baseUrl: String
    private var token: String?
    private let loginEndpoint = "/api/login"
    
    // MARK: - Object lifecycle
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: - Internal methods
    
    func login(parameters: [String: String], completionHandler: @escaping ServiceCompletionHandler<LoginResponse>) {
        guard let url = getURL(path: loginEndpoint, parameters: parameters) else {
            completionHandler(.failure(.malformedRequestUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        performRequest(request, completionHandler: completionHandler)
    }
    
    // MARK: - Private methods
    
    private func performRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping ServiceCompletionHandler<T>) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.apiError(error)))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.unknownResponse))
                return
            }
            
            guard response.statusCode == 200 else {
                completionHandler(.failure(.statusCode(response.statusCode)))
                return
            }
            
            do {
                let responseData: T = try APIParser.parse(data!)
                completionHandler(.success(responseData))
            } catch {
                completionHandler(.failure(.apiError(error)))
            }
        }.resume()
    }
    
    private func getURL(path: String, parameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            return nil
        }
        urlComponents.path = path
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        if token != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "token", value: token))
        }
        return urlComponents.url
    }
}
