//
//  StationCell.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setValue(entity: BikeStationEntity){
        lbName.text = entity.sna
        lbCount.text = "(\(entity.sbi)/\(entity.tot))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
