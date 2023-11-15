//
//  SeriesCollectionViewCell.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var seriesView: UIView!
    {
        didSet{
            seriesView.layer.cornerRadius = 20
            seriesView.backgroundColor = .white
            seriesView.layer.shadowOffset = CGSize(width: 5, height: 5)
            seriesView.layer.shadowRadius = 5
            seriesView.layer.shadowOpacity = 0.5
        }
    }
    @IBOutlet weak var seriesImg: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var seriesRate: UILabel!
    @IBOutlet weak var seriesYear: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
