//
//  StationGridCollectionCell.swift
//  SampleApp
//
//  Created by Aki Wang on 2021/6/29.
//

import UIKit
import SnapKit

class StationGridCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var lbName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setValue(indexPath: IndexPath, entity: BikeStationEntity){
        let x = rootView.superview?.x ?? 0
        let y = rootView.superview?.y ?? 0
        let width = rootView.superview?.bounds.width ?? 0
        let height = rootView.superview?.bounds.height ?? 0
        let x2 = x + width
        let y2 = y + height
        var str = "\(indexPath.row)\n\(entity.sna ?? "")\n"
        str += "\(String(format: "%.2f",x)) , \(String(format: "%.2f", y))\n"
        str += "\(String(format: "%.2f",x2)) , \(String(format: "%.2f", y2))\n"
        str += "\(String(format: "%.2f",width)) , \(String(format: "%.2f", height))"
        lbName.text = str
        
        let color: [UIColor] = [.red, .orange, .yellow, .green, .lightGray]
        rootView.backgroundColor = color[(entity.sno?.toInt() ?? 0) % color.count]
        
//        rootView.snp.remakeConstraisnts { maker in
//            let count = (entity.sno?.toInt() ?? 0) % color.count
//            let screenWidth = UIApplication.shared.windows.first { $0.isKeyWindow }?.width ?? 0
//            maker.width.equalTo(screenWidth / 3)
//            maker.height.equalTo(100 + (count * 20))
//        }
    }
}
