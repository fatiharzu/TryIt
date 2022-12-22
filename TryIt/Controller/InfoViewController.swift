//
//  InfoViewController.swift
//  TryIt
//
//  Created by imac on 22.12.22.
//

import UIKit

class InfoViewController: UIViewController {

    //information label
    @IBOutlet var infoLabel: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Schließt für Informationsseite
    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
