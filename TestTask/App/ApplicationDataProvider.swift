//
//  ApplicationDataProvider.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import Nuke

class ApplicationDataProvider {
    
    static let shared = ApplicationDataProvider()
    
    let apiKey = "3505cd5d6e584559ac8c8153d305d555"
    
    let networking: NetworkingProtocol
    let realm: RealmServiceProtocol
    
    let imagePipeline: ImagePipeline
    
    init(networking: NetworkingProtocol = Networking(),
         realm: RealmServiceProtocol = RealmService()) {
        self.networking = networking
        self.realm = realm
        
        self.imagePipeline = ImagePipeline {
            $0.dataLoader = DataLoader(configuration: {
                // Disable disk caching built into URLSession
                let conf = DataLoader.defaultConfiguration
                conf.urlCache = nil
                return conf
            }())

            $0.imageCache = ImageCache()
            $0.dataCache = try! DataCache(name: "com.github.kean.Nuke.DataCache")
        }
    }
}
