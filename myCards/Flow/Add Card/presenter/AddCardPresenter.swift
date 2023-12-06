//
//  AddCardPresenter.swift
//  myCards
//
//  Created by Mohamed Ali on 05/12/2023.
//

import Foundation

enum validationType {
    case accpeted
    case cardNumber
    case cardTitle
}

protocol AddCardProtocol: NSObject {
    func cardAddedSuccess(newCard: CardModel)
    func validation(validation: validationType)
    func cardNumberView(cardNumberForLabel: String,cardNumberForTextField: String)
}

extension AddCardProtocol {
    func cardAddedSuccess(newCard: CardModel) {}
    func validation(validation: validationType) {}
    func cardNumberView(cardNumberForLabel: String,cardNumberForTextField: String) {}
}

class AddCardPresenter {
    
    weak var viewdelegate: AddCardProtocol?
    
    init(viewdelegate: AddCardProtocol) {
        self.viewdelegate = viewdelegate
    }
    
    func validationCardNumber(text: String,range: NSRange, string: String) -> Bool {
        // Calculate the length of the final string after editing
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        let newTextLength = newText.count
        
        // If the total length exceeds 14, prevent further editing
        if newTextLength > 14 {
            return false
        }
        
        // If the total length is exactly 14, process the string
        if newTextLength == 14 {
            let lastNine = String(newText.suffix(4)) // Extract the last 5 digits
            
            let firstFiveHidden = "****" // Hide the first 5 digits
            
            let formattedText = "\(firstFiveHidden) \(lastNine)" // Combine the formatted text
            
            viewdelegate?.cardNumberView(cardNumberForLabel: formattedText, cardNumberForTextField: newText)
            
            return false // Prevent further editing
        }
        
        return true
    }
    
    func validationData(cardTitle: String,cardNumber: String) {
        
        if cardTitle.isEmpty {
            viewdelegate?.validation(validation: .cardTitle)
        }
        else {
            if cardNumber.isEmpty || cardNumber.count != 14 {
                viewdelegate?.validation(validation: .cardNumber)
            }
            else {
                viewdelegate?.validation(validation: .accpeted)
            }
        }
    }
}
