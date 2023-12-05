//
//  CardLayout.swift
//  myCards
//
//  Created by Mohamed Ali on 05/12/2023.
//

import UIKit

final class Singleton {
    static let shared = Singleton()
    var index: Int?
}

class CardLayout: UICollectionViewLayout {
    var contentHeight: CGFloat = 0.0
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    var nextIndexPath: Int?
           
    override init() {
        super.init()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        var size = super.collectionViewContentSize
        let collection = collectionView!
        size.width = collection.bounds.size.width
        if let _ = Singleton.shared.index{
            size.height = contentHeight+UIScreen.main.bounds.width/2+38
        }else{
            size.height = contentHeight
        }
        print("Contend",contentHeight)
        return size
    }
    
    
    func reloadData(){
        self.cachedAttributes = [UICollectionViewLayoutAttributes]()
    }
    
    override func prepare() {
        cachedAttributes.removeAll()
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0) else {
            return
        }
        for index in 0..<numberOfItems {
            let layout = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: index, section: 0))
            layout.frame = frameFor(index: index)
            
            if let indexExpand = Singleton.shared.index, indexExpand ==  index {
                self.nextIndexPath = index+1
                contentHeight = CGFloat(CGFloat(numberOfItems-1)*getCardSize())+UIScreen.main.bounds.width/2+38*2
            }else{
                contentHeight = CGFloat(CGFloat(numberOfItems-1)*getCardSize())+UIScreen.main.bounds.width/2+38
            }
            layout.zIndex = index
            layout.isHidden = false
            
            cachedAttributes.append(layout)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cachedAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(cachedAttributes[attributes.indexPath.item])
            }
            
        }
        return layoutAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    func frameFor(index: Int) -> CGRect {
        var frame = CGRect(origin: CGPoint(x: CGFloat(0), y:0), size: CGSize(width: UIScreen.main.bounds.width, height: CGFloat(UIScreen.main.bounds.width/2+38)))
        var frameOrigin = frame.origin
        if let indexExpand = Singleton.shared.index{
            if index > 0 {
                if indexExpand < index {
                    let spacesHeight = CGFloat((getCardSize() * CGFloat(index)))+UIScreen.main.bounds.width/2+38-getCardSize()/2
                    frameOrigin.y = spacesHeight
                }else{
                    frameOrigin.y = CGFloat((getCardSize() * CGFloat(index)))
                }
            }
        }else{
            if index > 0 {
                frameOrigin.y = CGFloat((getCardSize() * CGFloat(index)))
            }
        }
        frame.origin = frameOrigin
        return frame
    }
    func getCardSize()-> CGFloat{
        return CGFloat(48)
    }
    
}
