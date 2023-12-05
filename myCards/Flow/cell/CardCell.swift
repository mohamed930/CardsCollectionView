//
//  CardCell.swift
//  myCards
//
//  Created by Mohamed Ali on 03/12/2023.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardNumbers: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cardBodyView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ model: CardModel) {
        cardTitle.text = model.cardTitle
        cardNumbers.text = model.cardNumber
        balanceLabel.text = "$\(model.cardBalance)"
        
        cardBodyView.backgroundColor = UIColor().hexStringToUIColor(hex: model.backgroundColor)
        
        guard let last = model.last else { return }
        
        backgroundImage.isHidden = !last
    }

}
