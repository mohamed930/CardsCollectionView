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
        if (cardTitleTextField.text!.isEmpty) {
            showAlert(title: "Attention", describtion: "Please, fill the card title")
        }
        else {
            if (cardTitleTextField.text!.isEmpty) || cardNumberTextField.text?.count != 14 {
                showAlert(title: "Attention", describtion: "Please, fill the card number")
            }
            else {
                let card = CardModel(cardTitle: cardTitleLabel.text!, cardNumber: cardNumberLabel.text!, cardBalance: 0, backgroundColor: "#270685",last: true)
                delegate?.cardAddedSuccess(newCard: card)
                navigationController?.popViewController(animated: true)
            }
        }
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
                    
            // Calculate the length of the final string after editing
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            let newTextLength = newText.count
            
            // If the total length exceeds 14, prevent further editing
            if newTextLength > 14 {
                return false
            }
            
            // If the total length is exactly 14, process the string
            if newTextLength == 14 {
                let lastNine = String(newText.suffix(5)) // Extract the last 5 digits
                
                let firstFiveHidden = "****" // Hide the first 5 digits
                
                let formattedText = "\(firstFiveHidden) \(lastNine)" // Combine the formatted text
                
                cardNumberLabel.text = formattedText // Update the resultLabel
                
                textField.text = newText // Update the text field
                
                return false // Prevent further editing
            }
        }
        
        return true
    }
}
