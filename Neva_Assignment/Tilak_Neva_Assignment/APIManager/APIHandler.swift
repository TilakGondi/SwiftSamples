//
//  APIHandler.swift
//  Tilak_Neva_Assignment
//
//  Created by Tilakkumar Gondi on 07/06/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit



class APIHandler: NSObject {

    private let session:URLSession = .shared
    private let url:URL = URL.init(string: "https://test-api.nevaventures.com/")!
    typealias JSONObject = [String:Any]
    
    static let sharedInstance = APIHandler ()
    
    func getProfileData(completion: @escaping (_ profiles:[Profile]?, _ error:Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let responseData = data else {
                return completion(nil,error)
            }
            do{
                let responseObj = try JSONDecoder().decode(ResponseData.self, from: responseData)
                completion(responseObj.data, nil)
            }catch {
                print(error.localizedDescription)
                completion(nil, error)
            }  
        }
        task.resume()
    }
    
    
    func loadImage(from url:URL, completion: @escaping (UIImage) -> Void){
        let task = session.dataTask(with: url) { (imageData, _, _) in
            
            guard let imageData = imageData, let image = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
    
}
