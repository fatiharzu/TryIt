//
//  TryItViewController.swift
//  TryIt
//
//  Created by imac on 20.12.22.
//

import UIKit

class TryItViewController: UIViewController {
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var showActivityButton: UIButton!
    @IBOutlet weak var showDetailsButton: UIButton!
    @IBOutlet weak var activityTextLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    @IBOutlet weak var participantsTextLabel: UILabel!
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var accessibilityTextLabel: UILabel!
    @IBOutlet weak var linkTextLabel: UILabel!
    @IBOutlet weak var activityGifView: UIActivityIndicatorView!
    
    var currentTryIt : TryIt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background Image zeigt
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backimage")
        
        initUi()        
    }
    //zeigt Variablen zunächst als leer an
    func initUi() {
        activityGifView.stopAnimating()
        showDetailsButton.isHidden = true
        activityTextLabel.isHidden = true
        typeTextLabel.isHidden = true
        participantsTextLabel.isHidden = true
        priceTextLabel.isHidden = true
        accessibilityTextLabel.isHidden = true
        linkTextLabel.isHidden = true
        
        activityTextLabel.text = ""
        typeTextLabel.text = ""
        participantsTextLabel.text = ""
        priceTextLabel.text = ""
        accessibilityTextLabel.text = ""
        linkTextLabel.text = ""
        
    }  
    //Funktion zeigt, erneuert Variablen
    func updateUI() {
        guard let tryIt = self.currentTryIt else {
            activityTextLabel.text = ""
            typeTextLabel.text = ""
            participantsTextLabel.text = ""
            priceTextLabel.text = ""
            accessibilityTextLabel.text = ""
            linkTextLabel.text = ""
            typeTextLabel.isHidden = true
            participantsTextLabel.isHidden = true
            priceTextLabel.isHidden = true
            accessibilityTextLabel.isHidden = true
            linkTextLabel.isHidden = true
            return
        }
            showDetailsButton.isHidden = false
            activityTextLabel.isHidden = false
            activityTextLabel.text = tryIt.activity
            typeTextLabel.text = "Type: \(tryIt.type ?? "")"
            priceTextLabel.text = "Kostet etwa \((tryIt.price ?? 0.0)*100) Euro!"
            accessibilityTextLabel.text = "Dabei haben \((tryIt.accessibility ?? 0.0)*100)% Schwierigkeinten!"
            participantsTextLabel.text = "Kann mit \(tryIt.participants ?? 0) person(en) durchgeführt weden"
            linkTextLabel.text = tryIt.link
    }
    
    //Funktion zeigt Aktivität an
    func showActivity() {
        activateUI(enabled: false)
        
        TryItService.shared.loadShowTryIt { tryIt in
            
            OperationQueue.main.addOperation {
                self.activateUI(enabled: true)
                self.currentTryIt = tryIt
                self.updateUI()
            }
            
        } errorBlock: { error in
            
            OperationQueue.main.addOperation {
                self.activateUI(enabled: true)
                let alertView = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alertView.addAction(okAction)
                self.present(alertView, animated: true)
            }
        }
    }
    // Funktion zeigt activityView
    func activateUI(enabled: Bool) {
        showActivityButton.isEnabled = enabled
        showDetailsButton.isEnabled = enabled
        enabled ? activityGifView.stopAnimating() : activityGifView.startAnimating()
    }
    // Button, die neue Aktivität bringt
    @IBAction func showActivityButtonTouched(_ sender: UIButton) {
        self.currentTryIt = nil
        updateUI()
        showActivity()
    }
    // Button für detaillierte Informationen
    @IBAction func showDetailsButtonTouched(_ sender: UIButton) {
        sender.isHidden = true
        typeTextLabel.isHidden = false
        participantsTextLabel.isHidden = false
        priceTextLabel.isHidden = false
        accessibilityTextLabel.isHidden = false
        linkTextLabel.isHidden = false
    }
    //speichern button
    @IBAction func saveButtonTouched(_ sender: Any) {
        if let currentTryIt = currentTryIt {
            var titleText: String = ""
            if TryItService.shared.save(tryIt: currentTryIt) {
                titleText = "Activity Saved"
            }else{
                titleText = "Activity already Saved"
            }
            let alert = UIAlertController(title: titleText, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    // informationbutton
    
    @IBAction func infoButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "InfoSegue", sender: nil)
    }
}
