//
//  FlowLayout.swift
//  SampleApp
//
//  Created by Aki Wang on 2021/6/30.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    
    var rowCount = 3
    var computeSize: ((_ index: Int) -> (CGSize))?
    var attributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
//        self.minimumInteritemSpacing = 10
//        self.minimumLineSpacing      = 10
//
//        self.sectionInset.top        = 10
//        self.sectionInset.left       = 10
//        self.sectionInset.right      = 10
        if self.collectionView != nil {
            // 根據想要的column數量來計算一個cell的寬度
            let contentWidth:CGFloat = self.collectionView!.bounds.size.width - sectionInset.left - sectionInset.right
            let itemWidth = (contentWidth - minimumInteritemSpacing * (CGFloat(rowCount)-1)) / CGFloat(rowCount)
            
            // 計算cell的佈局
            let cellSize = computeAndStoreAttributes(CGFloat(itemWidth))

            // 佈局變化時記得跟著改變itemSize
            self.itemSize = cellSize
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    // 計算cell的frame以及設定item size來提供系統計算UICollectionView的contentSize
    fileprivate func computeAndStoreAttributes(_ itemWidth:CGFloat) -> CGSize {
        
        // 以sectionInset.top作為最初始的高度，紀錄每一個column的高度
        var columnHeights = [CGFloat](repeating: sectionInset.top, count: rowCount)
        
        // 記錄每一個column的item個數
        var columnItemCount = [Int](repeating: 0, count: rowCount)
        
        // 紀錄每一個cell的attributes
        attributes.removeAll()
        
        var row = 0
        for index in 0..<(self.collectionView?.numberOfItems() ?? 0) {
            // 建立一個attribute
            let indexPath = IndexPath.init(row: row, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 找出最短的Column
            let minHeight = columnHeights.sorted().first ?? 0
            let minHeightColumn = columnHeights.firstIndex(of: minHeight) ?? 0
            
            // 新的照片放到最短Column上
            columnItemCount[minHeightColumn] += 1
            let itemX = (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightColumn) + sectionInset.left
            let itemY = minHeight
            
            // 計算高度，按照原圖片大小等比例縮放
            var itemHeight = itemWidth
            if let size = computeSize?(index) {
                // 設定Frame，加入到attributes中
                itemHeight = size.height
                attribute.frame = CGRect(x: itemX, y: CGFloat(itemY), width: itemWidth, height: size.height)
            } else {
                // 設定Frame，加入到attributes中
                attribute.frame = CGRect(x: itemX, y: CGFloat(itemY), width: itemWidth, height: CGFloat(itemHeight))
            }
            attributes.append(attribute)
            
            // 計算最短的column當前的高度
            columnHeights[minHeightColumn] += itemHeight + minimumLineSpacing
            
            row += 1
        }
        
        // 找出最高的Column
        let maxHeight = columnHeights.sorted().last ?? 0
        let column = columnHeights.firstIndex(of: maxHeight) ?? 0
        
        // 用於系統計算collectionView的contentSize - 根據最高的Column來設置itemSize，使用總高度的平均值
        let itemHeight = (maxHeight - minimumLineSpacing * CGFloat(columnItemCount[column])) / CGFloat(columnItemCount[column])
        let cellSize = CGSize(width: itemWidth, height: itemHeight)
        return cellSize
    }
}
