//
//  RequestApi.swift
//  donefilmlist
//
//  Created by Lucas Rodrigues Dias on 13/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

struct Constants {
    //MARK: - Request
    static let httpMethodGet = "GET"
    static let httpMethodPost = "POST"
    
    //MARK: - ConstantsAPI
    static let apiKey = "?api_key=294499574f7d73123df8bff521171733&" //apiKey
    static let urlBase = "https://api.themoviedb.org/3" //baseUrl
    static let urlBaseImage = "https://image.tmdb.org/t/p/"
    static let language = "language=pt-BR"
    static let query = "query="
}

    //MARK: - EndPoints
enum EndPoints: String {
    case urlSearchMovies = "/search/movie"
    case urlPopularMovie = "/movie/popular"
    case urlUpComingMovie = "/movie/upcoming"
    case urlNowPlayingMovie = "/movie/now_playing"
    case urlDetailsMovie = "/movie/"
    case urlDetailsTelevision = "/tv/"
    case urlRecomendationMovie = "/recommendations"
    case urlSearchTelevison = "/search/tv"
    case urlPopularTv = "/tv/popular"
    case urlTopRatedTv = "/tv/top_rated"
    case urlOnTheAir = "/tv/on_the_air"
}

    //MARK: - RequestHTTP
class HTTPRequest {
    
    var task: TaskExecutor
    
    init(task: TaskExecutor = Executor()) {
        self.task = task
    }
    
    func requestGet<T: Decodable>(endPoint: EndPoints, type: T.Type, completion: @escaping (_ result: T?,_ error: Error?) -> Void) {
        
        guard let urlRequest = URL(string: Constants.urlBase + endPoint.rawValue + Constants.apiKey + Constants.language) else {
            print("fatalERROR")
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = Constants.httpMethodGet
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        task.execute(url: request) { data, response, error in
            if error != nil {
                print("fatalERROR in request")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if let data = data {
                do {
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(movies, nil)
                    }
                } catch {
                    print("ERROR in JSON: JSONSerialization")
                    print(error)
                    print(String.init(data: data, encoding: .utf8) ?? "")
                }
            }
        }
    }
    
     func requestGetSearch<T: Decodable>(endPoint: EndPoints, query: String, type: T.Type, completion: @escaping (_ result: T?,_ error: Error?) -> Void) {
        
        let formatedQuery: String = query.replacingOccurrences(of: " ", with: "+").folding(options: .diacriticInsensitive, locale: .current)
        
        guard let urlRequest = URL(string: Constants.urlBase + endPoint.rawValue + Constants.apiKey + Constants.language + "&query=" + formatedQuery) else {
            print("fatalERROR")
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = Constants.httpMethodGet
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       task.execute(url: request) { data, response, error in
            if error != nil {
                print("fatalERROR in request")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if let data = data {
                print(urlRequest)
                do {
                    
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(movies, nil)
                    }
                } catch {
                    print("ERROR in JSON: JSONSerialization")
                    print(error)
                    print(String.init(data: data, encoding: .utf8) ?? "")
                }
            }
        }
    }

     func requestGetDetails<T: Decodable>(endPoint: EndPoints, id: Int, type: T.Type, completion: @escaping (_ result: T?,_ error: Error?) -> Void) {
        
        guard let urlRequest = URL(string: Constants.urlBase + endPoint.rawValue + id.description + Constants.apiKey + Constants.language) else {
            print("fatalERROR")
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = Constants.httpMethodGet
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        task.execute(url: request) { data, response, error in
            if error != nil {
                print("fatalERROR in request")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if let data = data {
                do {
                    
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(movies, nil)
                    }
                } catch {
                    print("ERROR in JSON: JSONSerialization")
                    print(error)
                    print(String.init(data: data, encoding: .utf8) ?? "")
                }
            }
        }
    }
    
     func requestGetRecomendation<T: Decodable>(endPoint: EndPoints, id: Int, type: T.Type, completion: @escaping (_ result: T?,_ error: Error?) -> Void) {
        
        guard let urlRequest = URL(string: Constants.urlBase + endPoint.rawValue + id.description + "/recommendations" + Constants.apiKey + Constants.language) else {
            print("fatalERROR")
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = Constants.httpMethodGet
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        task.execute(url: request) { data, response, error in
            if error != nil {
                print("fatalERROR in request")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if let data = data {
                print(urlRequest)
                do {
                    
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(movies, nil)
                    }
                } catch {
                    print("ERROR in JSON: JSONSerialization")
                    print(error)
                    print(String.init(data: data, encoding: .utf8) ?? "")
                }
            }
        }
    }
    
}
