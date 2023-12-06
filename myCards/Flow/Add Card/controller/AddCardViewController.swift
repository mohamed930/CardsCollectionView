//
//  AddCardViewController.swift
//  myCards
//
//  Created by Mohamed Ali on 05/12/2023.
//

import UIKit

class AddCardViewController: UIViewController {
    
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var cardTitleTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    weak var delegate: AddCardProtocol?
    lazy var presenter = AddCardPresenter(viewdelegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Add new card"
        navigationController?.navigationBar.tintColor = UIColor(named: "#0032EE")
    }
    
    @IBAction func saveButtonAction (_ sender: Any) {
        presenter.validationData(cardTitle: cardTitleLabel.text!, cardNumber: cardNumberTextField.text!)
    }
}

extension AddCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cardTitleTextField {
            cardNumberTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cardTitleTextField {
            if let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                // Iterate through each character in the updated text
                cardTitleLabel.text = "\(text)"
            }
        }
        else {
            guard let currentText = textField.text else { return true }
            
            return presenter.validationCardNumber(text: currentText, range: range, string: string)
        }
        
        return true
    }
}

extension AddCardViewController: AddCardProtocol {
    func validation(validation: validationType) {
        switch validation {
        case .accpeted:
            let card = CardModel(cardTitle: cardTitleLabel.text!,
                                 cardNumber: cardNumberLabel.text!,
                                 cardBalance: 0,
                                 backgroundColor: "#270685",
                                 last: true
                                )
            delegate?.cardAddedSuccess(newCard: card)
            navigationController?.popViewController(animated: true)
        case .cardNumber:
            showAlert(title: "Attention", describtion: "Please, fill the card number")
        case .cardTitle:
            showAlert(title: "Attention", describtion: "Please, fill the card title")
        }
    }
    
    func cardNumberView(cardNumberForLabel: String,cardNumberForTextField: String) {
        cardNumberLabel.text = cardNumberForLabel
        cardNumberTextField.text = cardNumberForTextField
    }
}
