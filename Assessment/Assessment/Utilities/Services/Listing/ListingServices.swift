//
//  ListingServices.swift
//  Assessment
//
//  Created by APPLE on 19/01/21.
//

import Foundation
import SVProgressHUD

struct ListingServices {
    func listingRequest(completion: @escaping (_ success: Bool, _ teamData: [String: Team]?) -> ()) {
        NetworkServiceInterface.callWebService(serviceType: .sifeedsApi) { (response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                completion(false, nil)
                return
            }
            
            if let jsonData = response?.data {
                do {
                    let decodeObject = try JSONDecoder().decode(SIFeedData.self, from: jsonData)
                    if let TeamData = decodeObject.teams {
                        completion(true, TeamData)
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                        }
                    } else {
                        completion(false, nil)
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            return
                        }
                    }
                    
                } catch {
                    completion(false, nil)
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        return
                    }
                }
            } else {
                completion(false, nil)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    return
                }
            }
        }
    }
}
