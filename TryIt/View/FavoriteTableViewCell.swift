//
//  FavoritesTableViewCell.swift
//  TryIt
//
//  Created by imac on 21.12.22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    //Favotite Cell Label
    @IBOutlet weak var activityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    //Ändert die Farben der ausgewählten Linien
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        if selected {
            activityLabel.textColor = UIColor.black
            backgroundColor = UIColor.TryIt.color3
        }else{
            activityLabel.textColor = UIColor.white
            backgroundColor = UIColor.TryIt.color2
        }

        
    }

}
