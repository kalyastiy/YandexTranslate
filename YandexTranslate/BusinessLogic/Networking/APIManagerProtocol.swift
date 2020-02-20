//
//  APIManager.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 14.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol JSONDecodable {
  init?(JSON: [String: AnyObject])
}

enum APIResult<T> {
  case Success(T)
  case Failure(Error)
}

protocol APINetworkingProtocol {
  var sessionConfiguration: URLSessionConfiguration { get }
  var session: URLSession { get }
  
  func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
  func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
  
}

extension APINetworkingProtocol {
  func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
  
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      
      guard let HTTPResponse = response as? HTTPURLResponse else {
        
        let userInfo = [
          NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
        ]
        let error = NSError(domain: YTNetworkingErrorDomain, code: 100, userInfo: userInfo)
        
        completionHandler(nil, nil, error)
        return
      }
    
      if data == nil {
        if let error = error {
          completionHandler(nil, HTTPResponse, error)
        }
      } else {
        switch HTTPResponse.statusCode {
        case 200:
          do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
            completionHandler(json, HTTPResponse, nil)
          } catch let error as NSError {
            completionHandler(nil, HTTPResponse, error)
          }
        default:
            
            let userInfo = [
              NSLocalizedDescriptionKey: NSLocalizedString("Code \(HTTPResponse.statusCode)", comment: "")
            ]
            let error = NSError(domain: YTNetworkingErrorDomain, code: HTTPResponse.statusCode, userInfo: userInfo)
            
            completionHandler(nil, nil, error)

        }
      }
    }
    return dataTask
  }
  
  func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
    
    let dataTask = JSONTaskWith(request: request) { (json, response, error) in
      DispatchQueue.main.async(execute: {
        guard let json = json else {
          if let error = error {
            completionHandler(.Failure(error))
          }
          return
        }
        
        if let value = parse(json) {
          completionHandler(.Success(value))
        } else {
          let error = NSError(domain: YTNetworkingErrorDomain, code: 200, userInfo: nil)
          completionHandler(.Failure(error))
        }
        
      })
    }
    dataTask.resume()
  }
}
