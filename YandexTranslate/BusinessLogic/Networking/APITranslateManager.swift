//
//  APITranslateManager.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 14.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol FinalURLPoint {
  var baseURL: String { get }
  var path: String { get }
  var request: URLRequest { get }
}

enum ForecastType: FinalURLPoint {
    
    case Translate(text: String, from: Language, to: Language)

    var baseURL: String {
      return "https://translate.yandex.net"
    }
  
    var path: String {
       return "/api/v1.5/tr.json/translate"
    }
    
    private var parameters: [String: String]? {
        var p: [String: Any] = ["key": Constants.apiKey]

        switch self {
        case .Translate(text: let text, from: let from, to: let to):
            p["text"] = text
            p["lang"] = "\(from.code)-\(to.code)"
        }
        return p as? [String : String]
    }
    
    public var request: URLRequest {
        guard let url = self.url else {
            fatalError("Невозможно создать URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
    
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents?.url
    }

    
    private var method: HTTPMethod {
        return .get
    }

}

protocol APIManagerProtocol {
    
    func fetchCurrentWeatherWith(text: String, fromTranslate: Language, toTranslate: Language, completionHandler: @escaping (APIResult<TranslateModel>) -> Void)
}


final class APITranslateManager: APINetworkingProtocol, APIManagerProtocol {
    
      var sessionConfiguration: URLSessionConfiguration

      lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
      } ()
        
      init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
      }
      
      convenience init() {
        self.init(sessionConfiguration: URLSessionConfiguration.default)
      }
      
        func fetchCurrentWeatherWith(text: String, fromTranslate: Language, toTranslate: Language, completionHandler: @escaping (APIResult<TranslateModel>) -> Void) {
            let request = ForecastType.Translate(text: text, from: fromTranslate, to: toTranslate).request
        
            fetch(request: request, parse: { (json) -> TranslateModel? in
                 return TranslateModel(JSON: json)
            }, completionHandler: completionHandler)
        
      }
}

