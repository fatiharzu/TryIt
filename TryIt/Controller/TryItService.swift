//
//  TryItService.swift
//  TryIt
//
//  Created by imac on 21.12.22.
//

import UIKit
import CoreData

enum ServerSettings: String {
    case host = "https://www.boredapi.com/api/activity"
}

class TryItService {
    
    
    //Database AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var shared = TryItService()
    
    private var favoriteTryIts: [TryItFavorite] = []
    
    
    init () {
        loadContext()
    }
    
        //Bringt die in der API Variablen
    func loadShowTryIt(successBlock: @escaping (_ tryIt: TryIt) -> Void, errorBlock: @escaping (_ error: String) -> Void){
        
        guard let url: URL = URL(string: ServerSettings.host.rawValue) else { errorBlock("Invalid URL")
            return
        }
        
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                errorBlock("Error while requesting data from API. \(error?.localizedDescription as Any)")
                return
            }
            
            do{
                let getTryIt = try JSONDecoder().decode(TryIt.self, from: data)
                successBlock(getTryIt)
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
    
    func tryItAt(index: Int) -> TryItFavorite? {
        if index < favoriteTryIts.count {
            return favoriteTryIts[index]
        }
        return nil
    }
    //Speichert den Inhalt
    func save(tryIt: TryIt) -> Bool {
           if let key = tryIt.key {
               if isTryItSaved(tryItKey: key) {
                 return false
             }
               let showTryIt = TryItFavorite(context: self.context)
               showTryIt.activity = tryIt.activity ?? ""
               showTryIt.type = tryIt.type ?? ""
               showTryIt.key = tryIt.key ?? ""
               showTryIt.link = tryIt.link ?? ""
               showTryIt.accessibility = Double(tryIt.accessibility ?? 0)
               showTryIt.participants = Int64(tryIt.participants ?? 0)
               showTryIt.price = Double(tryIt.price ?? 0)
               favoriteTryIts.insert(showTryIt , at: 0)
               saveContext()
           }
           return true
       }
    //Schecks gespeichert werden
    func isTryItSaved(tryItKey: String) -> Bool {
            for aTryIt in favoriteTryIts {
                if aTryIt.key == tryItKey {
                    return true
                }
            }
            return false
        }
    //Löscht den Inhalt
    func delete(tryItKey: String) -> Bool {
            for (index, aTryIt) in favoriteTryIts.enumerated() {
                if aTryIt.key == tryItKey {
                    context.delete(favoriteTryIts[index])
                    favoriteTryIts.remove(at: index)
                    saveContext()
                    return true
                }
            }
            return false
        }
    
    // MARK: CoreData
    
    //Speichert den Inhalt in der Datenbank
    func saveContext() {
        do {
            try context.save()
        }catch{
            print("Error changing Activity in core data : \(error)")
        }
    }
    //Bringt die in der Datenbank gespeicherten Variablen
    func loadContext() {
        let request:NSFetchRequest<TryItFavorite> = TryItFavorite.fetchRequest()
        do {
            favoriteTryIts = try context.fetch(request)
        } catch {
            print("Error loading Aktivity from CoreData: \(error)")
        }
    }
    
}
