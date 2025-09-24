//
//  UServiceManager.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import Foundation
import Alamofire

class UServiceManager {
    static let shared: UServiceManager = UServiceManager()
    
    private init(){()}
    
    func callService<T: Decodable>(
        baseUrl: String = "https://fakestoreapi.com/",
        url: String = "",
        method: HTTPMethod = .get,
        success: @escaping (T?) -> Void,
        failure: @escaping(Error) -> Void
    ) {
        DispatchQueue.global(qos: .background).async {
            AF.request("\(baseUrl)\(url)", method: method).responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            let decoder: JSONDecoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            let decodedData =  try decoder.decode(T.self, from: data)
                            
                            DispatchQueue.main.async {
                                success(decodedData)
                            }
                        } catch let errorDecoding as DecodingError {
                            DispatchQueue.main.async {
                                failure(errorDecoding)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    case .failure(let err):
                        DispatchQueue.main.async {
                            failure(err)
                        }
                    }
            }
        }
    }
}
