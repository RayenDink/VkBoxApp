//
//  NetworkManager.swift
//  VK Client
//
//  Created by Rayen on 10/2/20.
//  Copyright © 2020 Rayen D. All rights reserved.//

import Foundation

class NetworkManager {
    
    private var urlComponents = URLComponents()
    private let constants = ConstNet()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    
    init() {
        
        urlComponents.scheme = constants.scheme
        urlComponents.host = constants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    // MARK: Authorization
    
    func fetchRequestAuthorization() -> URLRequest? {
        
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: constants.clientID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: constants.scope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        guard let url = urlComponents.url else { return nil }
        let request = URLRequest(url: url)
        
        
        return request
    }
    
    // MARK: Friends
    
    func fetchRequestFriends(completion: @escaping ([User]) -> ()) {
        
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
      session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()

                           decoder.keyDecodingStrategy = .convertFromSnakeCase
                          guard let friends = try decoder.decode(Response<User>.self, from: data).response?.items else { return }
                
                DispatchQueue.main.async {

                                      completion(friends)
                                 }
            } catch {
                print(error.localizedDescription)
            }
        }
        
       .resume()
    }
    // MARK: Photos User
    
    func fetchRequestPhotosUser(for ownerID: Int?), completion: @escaping ([Photo]) -> ()) {
        
        urlComponents.path = "/method/photos.getAll"
        
        guard let ownerID = ownerID else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: String(ownerID)),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
       session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
    let decoder = JSONDecoder()

                     decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let photo = try decoder.decode(Response<Photo>.self, from: data).response?.items else { return }
              
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    // MARK: Groups User
    
    func fetchRequestGroupsUser(completion: @escaping ([Group]) -> ()) {
        
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                      guard let groups = try decoder.decode(Response<Group>.self, from: data).response?.items else { return }

                       completion(groups)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        .resume()
    }
    
    // MARK: Search Groups
    
    func fetchRequestSearchGroups(text: String?, completion: @escaping ([Group]) -> ()) {
        
        urlComponents.path = "/method/groups.search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                  guard let searchGroups = try decoder.decode(Response<Group>.self, from: data).response?.items else { return }

                   completion(searchGroups)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        .resume()
    }
}
