//
//  GigController.swift
//  Gigs
//
//  Created by Marc Jacques on 3/17/20.
//  Copyright © 2020 Marc Jacques. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class GigController {
   
    
    // MARK: - Properties
    var bearer: Bearer?
    let baseURL = URL(string: "https://lambdagigapi.herokuapp.com/api")!
    
    
    // MARK: - Methods
    
    func signup(user: User, completion: @escaping (Error?) -> Void) {
        let signUpURL = baseURL.appendingPathComponent("/users/signup")
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            guard error == nil else {
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            completion(nil)
        }.resume()
    }
        
        func login(with user: User, completion: @escaping (Error?) -> Void) {
            let loginURL = baseURL.appendingPathComponent("/users/login")
            var request = URLRequest(url: loginURL)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
            } catch {
                print("Error encoding user object: \(error)")
                completion(error)
                return
            }
            
            URLSession.shared.dataTask(with: request) { ( data, response, error) in
                guard error == nil else {
                    completion(error)
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                    return
                }
                guard let data = data else {
                    completion(NSError())
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    self.bearer = try decoder.decode(Bearer.self, from: data)
                } catch {
                    print("Error decoding bearer object: \(error)")
                    completion(error)
                    return
                }
                completion(nil)
            }.resume()
        }
    }
