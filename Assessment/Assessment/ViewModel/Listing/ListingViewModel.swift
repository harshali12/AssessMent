//
//  ListingViewModel.swift
//  Assessment
//
//  Created by APPLE on 18/01/21.
//

import Foundation
import SVProgressHUD

class ListingViewModel {
    
    //ListingViewModel
    lazy var listServices:ListingServices = {
        return ListingServices()
    }()
    
    var players : [Player]? = []
    var teams : [Team]? = []
    
}

//MARK:- API Calls
extension ListingViewModel {
    func getListData(completion: @escaping(Bool) -> Void) {
        listServices.listingRequest() { (success, data) in
            if success {
                if let response = data {
                    for each in response  {
                        self.teams?.append(each.value)
                    }
                    self.saveFeedDataIntoLocalDB()
                } else {
                    print("error")
                }
            } else {
                print("error")
            }
            completion(success)
        }
    }
}

//MARK:- DataBinding {
extension ListingViewModel {
    func saveFeedDataIntoLocalDB() {
        UserDefaults.standard.setModelInUserDefaults(value: teams, key: .feedData)
    }
    
    func configureTeamData(teamIndex: Int) {
        players?.removeAll()
        if let teamLocalDBData = UserDefaults.standard.getSavedModelFromUserDefaults(type: [Team].self, key: .feedData) {
            let playersData = teamLocalDBData[teamIndex].players
            for player in playersData {
                self.players?.append(player.value)
                
            }
        }
    }

    
    func configurePlayerData(playerIndex: Int) -> Player? {
        if players?.count ?? 0 > 0 {
        return players?[playerIndex]
        }
        return nil
    }
    
    func getTeamCount() -> Int {
        return teams?.count ?? 0
    }
    
    func getPlayerCount(index: Int) -> Int {
        return players?.count ?? 0
    }
}

