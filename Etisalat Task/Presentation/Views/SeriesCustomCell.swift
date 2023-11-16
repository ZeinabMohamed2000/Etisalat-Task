//
//  SeriesCustomCell.swift
//  Etisalat Task
//
//  Created by Zeinab on 15/11/2023.
//

import UIKit
import Kingfisher

class SeriesCustomCell: UITableViewCell {
    @IBOutlet weak var stackView: UIStackView!{
        didSet
            {
                stackView.layer.cornerRadius = 20
                stackView.backgroundColor = .white
                stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
                stackView.layer.shadowRadius = 5
                stackView.layer.shadowOpacity = 0.5
           
            }
    }
    @IBOutlet weak var seriesView: UIView!{
        didSet{
            seriesView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var hiddenView: UIView!{
        didSet{
            hiddenView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var seriesImg: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var seriesYear: UILabel!
    @IBOutlet weak var seriesRate: UILabel!
    @IBOutlet weak var seriesDesc: UILabel!
    @IBOutlet weak var seriesType: UILabel!
    
    var isExpanded = false {
        didSet{
            hiddenView.isHidden = isExpanded
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, url: String, rate: String, year: Int, description: String, type: String){
        seriesName.text = title
        seriesDesc.text = "Description: \(description)"
        seriesType.text = "Type: \(type)"
        seriesRate.text = rate
        seriesYear.text = "\(year)"
        seriesImg.kf.setImage(with: URL(string: url))
    }
    
}
