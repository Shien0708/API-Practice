//
//  SongTableViewCell.swift
//  API Practice
//
//  Created by Shien on 2022/5/26.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
