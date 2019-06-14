//
//  ProfileCell.swift
//  Tilak_Neva_Assignment
//
//  Created by Tilakkumar Gondi on 06/06/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit



class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var profile_img: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var skills_lbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var profileData: Profile? {
        didSet{
            displayProfile(self.profileData)
        }
    }
    
    private var generation = 0


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profile_img.layer.cornerRadius = self.profile_img.frame.width/2
        activityIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.name_lbl.text = nil
        self.skills_lbl.text = nil
        self.profile_img.image = nil
        generation += 1
    }
    
    private func displayProfile(_ profile:Profile?){
        guard let profile = profile, profile.name != "" else {
            return
        }
        self.name_lbl.text = profile.name
        self.skills_lbl.text = profile.skills
        guard let imageUrl:URL = URL(string: profile.image ?? "") else {
            self.activityIndicator.stopAnimating()
            return
        }
        // to load the image without being repeated
        let currentGeneration = generation
        
//        APIHandler.sharedInstance.loadImage(from: imageUrl) { (image) in
//        }

        APIHandler.sharedInstance.loadImage(from: imageUrl) { (image, error) in
            if error == nil && image != nil{
                guard currentGeneration == self.generation else { return }
                self.profile_img.image = image
            }
            self.activityIndicator.stopAnimating()

        }
        
    }
}
