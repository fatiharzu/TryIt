//
//  TryItService.swift
//  TryIt
//
//  Created by imac on 21.12.22.
//

import Foundation

enum serverSettings: String {
    case host = "https://www.boredapi.com/api/activity/"
}

class TryItService {
    
    
    static var shared = TryItService()
    
    private var favoriteTryIts: [TryIt] = []
    
    func loadShowTryIt(successBlock: @escaping (_ tryIt: TryIt) -> Void, errorBlock: @escaping (_ error: String) -> Void){
        guard let url: URL = URL(string: serverSettings.host.rawValue) else { errorBlock("Invalid URL")
            return
        }
        
        let urlSeesion = URLSession.shared
        let task = urlSeesion.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                errorBlock("Error while requesting data from API. \(error?.localizedDescription as Any)")
                return
            }
            
            do{
                let newTryIt = try JSONDecoder().decode(TryIt.self, from: data)
                successBlock(newTryIt)
            } catch {
                errorBlock("Error while parsing data")
            }
        }
        task.resume()
    }
    //MARK: Favorites TryIt
    
    var tryItCount: Int {
        favoriteTryIts.count
    }
    
    func tryItAt(index: Int) -> TryIt? {
        if index < favoriteTryIts.count {
            return favoriteTryIts[index]
        }
        return nil
    }
    
    func save(tryIt: TryIt) -> Bool {
        if isTryItSaved(tryItKey: tryIt.key) {
            return false
        }
        favoriteTryIts.insert(tryIt, at: 0)
        return true
    }
    
    func isTryItSaved(tryItKey: Int) -> Bool {
        for aTryIt in favoriteTryIts {
            if aTryIt.key == tryItKey{
                return true
            }
        }
        return false
    }
    
    func delete(tryItKey: Int) -> Bool {
        for (index, aTryIt) in favoriteTryIts.enumerated() {
            if aTryIt.key == tryItKey {
                favoriteTryIts.remove(at: index)
                return true
            }
        }
        return false
    }
    
}
