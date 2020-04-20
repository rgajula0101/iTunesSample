//
//  ITunesSearchResult.swift
//  iTunes_Search_App
//
//  Created by Rakesh Kumar on 4/15/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit
import SDWebImage


class CustomButton: UIButton{

    var row: Int = 0
    var section: Int = 0

}

class ITunesSearchResultCell: UITableViewCell {


    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionName: UILabel!

    @IBOutlet weak var artistImageView: CircularImage!
    
    
    @IBOutlet weak var favButton: CustomButton!
    
    var iTunesResult: ItunesAPIResult! {
        didSet {
            artistNameLabel.text = iTunesResult.artistName
            trackNameLabel.text = iTunesResult.trackName
            collectionName.text = iTunesResult.collectionName
            
             let url = URL(string: iTunesResult.artworkUrl60!)
            artistImageView.sd_setImage(with: url)
            
        }
        
    }
    

}
