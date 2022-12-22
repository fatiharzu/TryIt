//
//  FavoritesTableViewController.swift
//  TryIt
//
//  Created by imac on 21.12.22.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    //Deklariert selectedTryIt in der Datenbank TryitFavorite
    var selectedTryIt: TryItFavorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Favorits"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TryItService.shared.tryItCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as!
        FavoriteTableViewCell
        
        if let currentTryIt = TryItService.shared.tryItAt(index: indexPath.row) {
            cell.activityLabel.text = currentTryIt.activity
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                            indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            
            let alert = UIAlertController(title: "Are you sure, this activity remove?", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
                OperationQueue.main.addOperation {
                    if let tryIt = TryItService.shared.tryItAt(index: indexPath.row) {
                        if let key = tryIt.key {
                            _ = TryItService.shared.delete(tryItKey: key)
                        }
                    }
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                        self.tableView.reloadData()
                    }
                }
            }))
            self.present(alert, animated: true)
        }
        contextItem.backgroundColor = UIColor.TryIt.color5
        
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "\(TryItService.shared.tryItCount) saved Activities"
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentTryIt = TryItService.shared.tryItAt(index: indexPath.row) {
            selectedTryIt = currentTryIt
            performSegue(withIdentifier: "DetailsSegue", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailTableViewController
        destinationVC.tryIt = selectedTryIt
    }
}

