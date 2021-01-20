//
//  ListingTableViewCell.swift
//  Assessment
//
//  Created by APPLE on 19/01/21.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var playerNameLbl: UILabel!
    
    static let reuseIdentifier = "ListingTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- Data Binding
    func configureTeamData(data: Player?) {
        guard let name = data?.nameFull else {
            return
        }
        var isCaptain = false
        var isWicketKipper = false
        if let captain = data?.iscaptain {
            isCaptain = captain
        }
        if let wicketKipper = data?.iskeeper {
            isWicketKipper = wicketKipper
        }
        if isCaptain {
            playerNameLbl.text = "\(name) (C)"
            playerNameLbl.textColor = .black
        } else if isWicketKipper {
            playerNameLbl.text = "\(name) (W)"
            playerNameLbl.textColor = .black
        } else {
            playerNameLbl.text = "\(name)"
            playerNameLbl.textColor = .darkGray

        }
    }
    
}
