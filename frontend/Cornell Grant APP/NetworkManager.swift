//
//  NetworkManager.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/26/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import Foundation
import Alamofire

// How do we make network calls?
class NetworkManager {
    private static let endpoint = "gonna fill this in with backend magic"

    static func getGrants(completion: @escaping ([HomeGrant]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let grantsResponse = try? jsonDecoder.decode(GrantResponse.self, from: data) {
                    completion(grantsResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//    static func getGrants2() {
//        if let path = Bundle.main.path(forResource: "output", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)as? [[String]]
//                var lstgrantsfinal = [HomeGrant]()
//                for _ in jsonResult! {
//                    let name = jsonResult![0][0]
//                    let org = jsonResult![0][1]
//                    let due = jsonResult![0][2]
//                    let amt = jsonResult![0][3]
//                    let lstgrant = HomeGrant(Grantname: name, Grantorg: org, Grantamt: due, Grantdue: amt)
//                    lstgrantsfinal.append(lstgrant)
//                    return lstgrantsfinal
//                        }
//            } catch {
//                print("Big L")
//            }
//        }
//}
//}
