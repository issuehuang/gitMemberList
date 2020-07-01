//
//  ConnectionTools.swift
//  gitMemberList
//
//  Created by APP技術部-黃一修 on 2020/6/30.
//  Copyright © 2020 APP技術部-黃一修. All rights reserved.
//

import Foundation
class ConnectionTools: NSObject {
    static let share:ConnectionTools = ConnectionTools()
    typealias Complate = (Data?, Error?) -> Void

    func getUserList(completion:@escaping(_ isSuccess:Bool,_ error:Error?, [UserProfileListModel]?)->()){
        
        let urlStr = "https://api.github.com/users"
        let paramDic = ["since":"0","per_page":"20"]
        requestWithURL(urlString: urlStr, parameters: paramDic) { (data, error) in
            guard let data = data else {
                        completion(false, error, nil)
                        return
                    }
            DispatchQueue.main.async {
                      let decoder = JSONDecoder()
                      let encoder = JSONEncoder()
                      encoder.outputFormatting = .prettyPrinted
                      do{
                          let userList = try decoder.decode([UserProfileListModel].self, from: data)
                          completion(true,nil,userList)
                      }catch let error{
                          completion(false, error,nil)
                      }
                  }
        }
    }
    func getUserDetail(loginStr:String,completion:@escaping (_ isSuccess:Bool, _ error:Error?, UserProfileDetailModel?) -> ()) {
        let urlStr = "https://api.github.com/users/\(loginStr)"

               requestWithURL(urlString: urlStr, parameters: [:]) { (data, error) in
                   guard let data = data else {
                               completion(false, error, nil)
                               return
                           }
                   DispatchQueue.main.async {
                             let decoder = JSONDecoder()
                             let encoder = JSONEncoder()
                             encoder.outputFormatting = .prettyPrinted
                             do{
                                 let userDetail = try decoder.decode(UserProfileDetailModel.self, from: data)
                                 completion(true,nil,userDetail)
                             }catch let error{
                                 completion(false, error,nil)
                             }
                         }
               }
    }
    
    
    func requestWithURL(urlString: String, parameters: [String: Any], completion: @escaping (Complate)){
        
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = []
        
        for (key, value) in parameters{
            guard let value = value as? String else{return}
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let queryedURL = urlComponents.url else{return}
        
        let request = URLRequest(url: queryedURL)
        
        fetchedDataByDataTask(from: request, completion: completion)
    }
    
    private func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Complate)){
           
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               
               let status = (response as? HTTPURLResponse)?.statusCode ?? 0
               print("response status: \(status)")
               
               if error != nil{
                   completion(data,error)
                   print(error as Any)
               }else{
                   guard let data = data else{return}
                   DispatchQueue.main.async {
                       completion(data, error)
                     
                   }
               }
           }
           task.resume()
       }
}
