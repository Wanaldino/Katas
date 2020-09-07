//
//  Valid Braces.swift
//  
//
//  Created by Wanaldino Antimonio on 07/09/2020.
//  URL: https://www.codewars.com/kata/5277c8a221e209d3f6000b56/train/swift

//Write a function that takes a string of braces, and determines if the order of the braces is valid. It should return true if the string is valid, and false if it's invalid.
//
//This Kata is similar to the Valid Parentheses Kata, but introduces new characters: brackets [], and curly braces {}. Thanks to @arnedag for the idea!
//
//All input strings will be nonempty, and will only consist of parentheses, brackets and curly braces: ()[]{}.
//
//What is considered Valid?
//A string of braces is considered valid if all braces are matched with the correct brace.
//
//Examples
//"(){}[]"   =>  True
//"([{}])"   =>  True
//"(}"       =>  False
//"[(])"     =>  False
//"[({})](]" =>  False


import Foundation

infix operator **
infix operator ***
enum AllowedCharacters {
    case open(Open)
    case close(Close)
    
    init?(rawValue: String) {
        if let open = Open(rawValue: rawValue) {
            self = .open(open)
        } else if let close = Close(rawValue: rawValue) {
            self = .close(close)
        } else {
            return nil
        }
    }
    
    enum Open: String {
        case parentesisOpen = "("
        case bracketsOpen = "["
        case bracesOpen = "{"
        
        static func ***(l: Open, r: Close) -> Bool {
            switch (l, r) {
            case (.parentesisOpen, .parentesisClose):
                return true
            case (.bracketsOpen, .bracketsClose):
                return true
            case (.bracesOpen, .bracesClose):
                return true
            default:
                return false
            }
        }
    }
    enum Close: String {
        case parentesisClose = ")"
        case bracketsClose = "]"
        case bracesClose = "}"
    }
    
    static func **(l: AllowedCharacters, r: AllowedCharacters) -> Bool? {
        switch (l, r) {
        case (_, .open):
            return nil
        case (.open(let openChar), .close(let closeChar)):
            return openChar *** closeChar
        case (.close, .close):
            return false
        }
    }
}

func validBraces(_ string:String) -> Bool {
    let allowedCharacters = string.compactMap({ AllowedCharacters(rawValue: $0.description) })
    if !allowedCharacters.count.isMultiple(of: 2) { return false }
    var remainingCharacters = [AllowedCharacters]()
    for character in allowedCharacters {
        guard let lastRemainingCharacter = remainingCharacters.last else { remainingCharacters.append(character); continue }
        guard let closes = lastRemainingCharacter ** character else { remainingCharacters.append(character); continue }
        if closes {
            remainingCharacters.removeLast()
        } else {
            return false
        }
    }
    return remainingCharacters.count == 0
}
