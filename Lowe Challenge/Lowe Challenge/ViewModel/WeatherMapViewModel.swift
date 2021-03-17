//
//  WeatherMapViewModel.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import Foundation

enum WeatherAPIError: String, Error {
    case BadURL = "Please try again later"
    case BadResponse = "City not found. Plese enter a different city"
}


protocol WeatherMapViewModelProtocol {
    
    func fetchCharactersAPIRequest(with parameter: String, _ completionHandler: @escaping (Result<WeatherAPI?, WeatherAPIError>) -> Void)
}

class WeatherMapViewModel: WeatherMapViewModelProtocol {
    
    private var resultsModel: WeatherAPI?
    
    func buildRequest(with paramter: String) -> URLRequest? {
        let queryItems = [URLQueryItem(name: "q", value: paramter), URLQueryItem(name: "appid", value: Constants.apiKey)]
        var urlComponenets = URLComponents(string: Constants.weatherURL)
        urlComponenets?.queryItems = queryItems
        guard let url = urlComponenets?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    func fetchCharactersAPIRequest(with parameter: String, _ completionHandler: @escaping (Result<WeatherAPI?, WeatherAPIError>) -> Void) {
        let urlSession = URLSession.shared
        guard let urlRequest = buildRequest(with: parameter) else {
            completionHandler(.failure(WeatherAPIError.BadURL))
            return
        }
        let dataTask = urlSession.dataTask(with: urlRequest) {[weak self] (data, response, error) in
            
            guard let self = self,
                  error == nil else {
                completionHandler(.failure(WeatherAPIError.BadResponse))
                return
            }
            if let data = data {
                do {
                    let responseModel = try JSONDecoder().decode(WeatherAPI.self, from: data)
                    self.resultsModel = responseModel
                    completionHandler(.success(responseModel))
                } catch {
                    completionHandler(.failure(.BadResponse))
                }

            }
        }
        dataTask.resume()
    }
}
