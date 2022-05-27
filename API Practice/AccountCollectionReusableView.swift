//
//  AccountCollectionReusableView.swift
//  API Practice
//
//  Created by Shien on 2022/5/27.
//

import UIKit

class AccountCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var postCountsLabel: UILabel!
    
    
    func updateUI(with user: IGUser?) {
        if let user = user {
            bioLabel.text = user.biography
            userNameLabel.text = user.full_name
            headImageView.image = try? UIImage(data: Data(contentsOf: user.profile_pic_url_hd))
            followLabel.text = "\(user.edge_follow.count)/nFollowing"
            followersLabel.text = "\(user.edge_followed_by.count)/nFollowers"
            postCountsLabel.text = "\(user.edge_owner_to_timeline_media.count)/nPosts"
            linkButton.setTitle("\(user.external_url)", for: .normal)
        }
        
    }
    
}
