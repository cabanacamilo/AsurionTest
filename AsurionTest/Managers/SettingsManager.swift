//
//  SettingsManager.swift
//  AsurionTest
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class SettingsManager {
    
    private let resourceName = "ConfigJson"
    
    func loadData(complition: @escaping(Result<Settings, LoadingError>) -> Void) {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: "txt"){
            if let data = try? Data(contentsOf: url) {
                do {
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    let settings = getSettings(json)
                    complition(.success(settings))
                }
            } else {
                complition(.failure(.cannotLoadData))
            }
        } else {
            complition(.failure(.cannotFindData))
        }
    }
    
    private func getSettings(_ jsonInfo: NSDictionary?) -> Settings {
        let settingsInformation = jsonInfo?["settings"] as? NSDictionary
        let isChatEnabled = settingsInformation?["isChatEnabled"] as? Bool ?? false
        let isCallEnabled = settingsInformation?["isCallEnabled"] as? Bool ?? false
        let workHours = settingsInformation?["workHours"] as? String ?? ""
        return Settings(isChatEnabled: isChatEnabled, isCallEnabled: isCallEnabled, workHours: workHours)
    }
}
