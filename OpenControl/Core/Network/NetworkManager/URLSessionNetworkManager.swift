//
//  SimpleNetworkManager.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

final class URLSessionNetworkManager: NetworkManager {

    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {

        var components = URLComponents()
        components.scheme = endpoint.scheme
        // TODO: Fix this later
        components.host = String(endpoint.baseURL.split(separator: ":").first!)
        components.port = Int(endpoint.baseURL.split(separator: ":").last!)
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else { return }
        
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let params = endpoint.parameters {
            do {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: params,
                    options: .prettyPrinted
                )
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }

        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completionOnMain(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else {
                return completionOnMain(.failure(ManagerErrors.invalidResponse))
            }
            
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }

            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(decodedData))
            } catch {
                completionOnMain(.failure(error))
            }
        }

        urlSession.resume()
    }
}
