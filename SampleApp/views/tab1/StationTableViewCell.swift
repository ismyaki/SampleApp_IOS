//
//  StationCell.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

protocol StationTableViewCellDelegate{
    func onClickCopy(_ view: UIView, selectEntity: BikeStationEntity)
    func onClickDel(_ view: UIView, selectEntity: BikeStationEntity)
}

class StationTableViewCell: UITableViewCell {
    
    var entity: BikeStationEntity? = nil
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    
    var delegate: StationTableViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setValue(entity: BikeStationEntity){
        self.entity = entity
        lbName.text = entity.sna
        lbCount.text = "(\(entity.sbi)/\(entity.tot))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onClickCopy(_ sender: UIButton) {
        if let entity = entity {
            delegate?.onClickCopy(sender, selectEntity: entity)
        }
    }
    
    @IBAction func onClickDel(_ sender: UIButton) {
        if let entity = entity {
            delegate?.onClickDel(sender, selectEntity: entity)
        }
    }
}
