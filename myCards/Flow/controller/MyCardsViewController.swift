//
//  MyCardsViewController.swift
//  myCards
//
//  Created by Mohamed Ali on 03/12/2023.
//

import UIKit

class MyCardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    private var virtualCardList = Array<CardModel>()
    private lazy var presenter = myCardsPresneter(viewDelegate: self)
    private var selectedCard: CardModel!
    static var selectedCardFlag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        regeesterCollectionView()
        fetchData()
    }
    
    func configureUI() {
        navigationController?.isNavigationBarHidden = true
        confirmButton.SetButtonEnabledOrDisabled(status: false)
    }
    
    func regeesterCollectionView() {
        collectionView.registerNib(cell: CardCell.self)
        let layout = CardLayout()
        collectionView.collectionViewLayout = layout
    }
    
    @IBAction func confirmButtonAction (_ sender: Any) {
        let alert = UIAlertController(title: "Confirmed", message: "Are you sure to confirm \"\(selectedCard.cardTitle)\" card?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: { [weak self] _ in
            guard let self = self else { return }
            
            self.returnAllCardToInitView()
        }))
        
        present(alert, animated: true)
    }
    
    func fetchData() {
        presenter.fetchCardsOperation()
    }
    
}

extension MyCardsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var kCellHeight: CGFloat {
        return UIScreen.main.bounds.width/2+38
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return virtualCardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeue(indexPath: indexPath) as CardCell
        
        cell.configureCell(virtualCardList[indexPath.row])
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: CGFloat(kCellHeight))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /// Be attention i worte this line to make the card return to normal place.
        if indexPath.row == virtualCardList.count - 1 {
            // Last Element.
            MyCardsViewController.selectedCardFlag = !MyCardsViewController.selectedCardFlag
            presenter.cardSelectedOperation(index: indexPath.row,selected: !MyCardsViewController.selectedCardFlag)
        }
        else {
            if Singleton.shared.index == indexPath.row {
                Singleton.shared.index = virtualCardList.count - 1
                presenter.cardSelectedOperation(index: indexPath.row,selected: false)
            }
            else {
                Singleton.shared.index = indexPath.row
                presenter.cardSelectedOperation(index: indexPath.row,selected: true)
            }
            
            collectionView.performBatchUpdates({})
        }
    }
    
    private func returnAllCardToInitView() {
        Singleton.shared.index = virtualCardList.count - 1
        collectionView.performBatchUpdates({})
        confirmButton.SetButtonEnabledOrDisabled(status: false)
        MyCardsViewController.selectedCardFlag = true
    }
    
}


extension MyCardsViewController: myCardsProtocol {
    
    func fetchCardsSuccessfully(cards: [CardModel]) {
        virtualCardList = cards
        collectionView.reloadData()
    }
    
    func makeButtonEnabled(card: CardModel?) {
        guard let card else {
            confirmButton.SetButtonEnabledOrDisabled(status: false)
            return
        }
        
        confirmButton.SetButtonEnabledOrDisabled(status: true)
        selectedCard = card
    }
    
}
