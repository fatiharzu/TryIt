//
//  TryItViewController.swift
//  TryIt
//
//  Created by imac on 20.12.22.
//

import UIKit

class TryItViewController: UIViewController {
    
  
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
    
    
    func showActivity() {
        
    }
    
    func updateUI() {
        
    }
    
    func activateUI() {
        
    }
   

}
