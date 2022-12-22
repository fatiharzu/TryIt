//
//  DetailTableViewController.swift
//  TryIt
//
//  Created by imac on 21.12.22.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    //TryItFavorite-DataModel Klasse in Variablentypen erstellt
    var tryIt: TryItFavorite?
    
    //Mit der Tabelle verknüpfte Variablen (Labels)
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showTryIt()
    }
    // Es zeigt die Variablen im Detail an.
    
    func showTryIt() {        
        guard let tryIt = tryIt else {
            return
        }
        activityLabel.text = tryIt.activity
        typeLabel.text = "Type: \(tryIt.type ?? "")"
        participantsLabel.text = "Mit wie vielen Pers. \(tryIt.participants)"
        priceLabel.text = "ca. \((tryIt.price )*100) Euro!"
        accessLabel.text = "Schwierigkeit: \((tryIt.accessibility )*100)%"
        linkLabel.text = tryIt.link
        
    }
    // Klicken Sie zum Löschen auf die Schaltfläche „Löschen“ und löschen Sie die Tabelle
    
    @IBAction func delteButtonTouchede(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure, remove this activity from favourites?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            if let tryIt = self.tryIt {
            if let key = tryIt.key {
            _ = TryItService.shared.delete(tryItKey: key)
            self.navigationController?.popViewController(animated: true)
         }
       }
    }))
        present(alert, animated: true)
    }

    //Zeigt den Titel (Typ) der Tabelle an.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tryIt?.type
    }

    

}
