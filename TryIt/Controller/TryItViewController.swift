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
    @IBOutlet weak var activitTextView: UITextView!
    @IBOutlet weak var typeTextView: UITextView!
    @IBOutlet weak var participantTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var accessibilityTextView: UITextView!
    @IBOutlet weak var linkTextView: UITextView!
    @IBOutlet weak var activityGifView: UIActivityIndicatorView!
    
    var currentTryIt : TryIt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUi()
    }
    
    func initUi() {
        
        activityGifView.stopAnimating()
        showDetailsButton.isHidden = true
        activitTextView.isHidden = true
        typeTextView.isHidden = true
        participantTextView.isHidden = true
        priceTextView.isHidden = true
        accessibilityTextView.isHidden = true
        linkTextView.isHidden = true
        
        activitTextView.text = ""
        typeTextView.text = ""
        participantTextView.text = ""
        priceTextView.text = ""
        accessibilityTextView.text = ""
        linkTextView.text = ""
        
        
    }  
    
    func updateUI() {
        guard let tryIt = self.currentTryIt else {
            activitTextView.text = ""
            typeTextView.text = ""
            participantTextView.text = ""
            priceTextView.text = ""
            accessibilityTextView.text = ""
            linkTextView.text = ""
            typeTextView.isHidden = true
            participantTextView.isHidden = true
            priceTextView.isHidden = true
            accessibilityTextView.isHidden = true
            linkTextView.isHidden = true
            return
        }
        accessibilityTextView.text = tryIt.activity
        typeTextView.text = tryIt.type
        participantTextView.text = "\(tryIt.participants)"
        priceTextView.text = "\(tryIt.price)"
        accessibilityTextView.text = "\(tryIt.accessibility)"
        linkTextView.text = tryIt.link
    }
    func showActivity() {
        activateUI(enabled: false)
        
        TryItService.shared.loadShowTryIt { tryIt in
            OperationQueue.main.addOperation {
                self.activateUI(enabled: true)
                self.currentTryIt = tryIt
                self.updateUI()
            }
        }errorBlock: { error in
            OperationQueue.main.addOperation {
                self.activateUI(enabled: true)
                let alertView = UIAlertController(title: "Wrong!", message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alertView.addAction(okAction)
                self.present(alertView, animated: true)
            }
        }
    }
    
    func activateUI(enabled: Bool) {
        showActivityButton.isEnabled = enabled
        showDetailsButton.isEnabled = enabled
        enabled ? activityGifView.stopAnimating() : activityGifView.startAnimating()
    }
    
    
    @IBAction func showActivityButtonTouched(_ sender: UIButton) {
        self.currentTryIt = nil
        updateUI()
        showActivity()
    }
    @IBAction func showDetailsButtonTouched(_ sender: UIButton) {
        sender.isHidden = true
        typeTextView.isHidden = false
        participantTextView.isHidden = false
        priceTextView.isHidden = false
        accessibilityTextView.isHidden = false
        linkTextView.isHidden = false
    }
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
    
}
