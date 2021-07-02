//
//  MoviesListTableViewCell.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit
//custom identifier cell: moviesList
class MoviesListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
