//
//  MainManager.swift
//  AsurionTest
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class PetsManager {
    
    private let resourceName = "PetsJson"
    
    func loadData(complition: @escaping(Result<[Pet], LoadingError>) -> Void) {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: "txt"){
            if let data = try? Data(contentsOf: url) {
                do {
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    let pets = self.getPets(json)
                    complition(.success(pets))
                }
            } else {
                complition(.failure(.cannotLoadData))
            }
        } else {
            complition(.failure(.cannotFindData))
        }
    }
    
    private func getPets(_ jsonInfo: NSDictionary?) -> [Pet] {
        var getPets = [Pet]()
        let petsInformation = jsonInfo?["pets"] as? NSArray
        if let pets = petsInformation {
            for i in pets {
                let pet = i as? NSDictionary
                let contentUrl = pet?["content_url"] as? String ?? ""
                let dateFromJson = pet?["date_added"] as? String ?? ""
                let dateAdded = stringToDate(dateFromJson)
                let imageUrl = pet?["image_url"] as? String ?? ""
                let title = pet?["title"] as? String ?? ""
                getPets.append(Pet(imageUrl: imageUrl, title: title, contentUrl: contentUrl, dateAdded: dateAdded))
            }
        }
        return getPets
    }
    
    private func stringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string) ?? Date()
        return date
    }
}
