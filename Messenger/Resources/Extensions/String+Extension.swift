//
//  String+Extension.swift
//  Messenger
//
//  Created by Binaya on 21/06/2022.
//

import Foundation

extension String {
    
    /// Email validation
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
    
    /// Encoding the white spaces in the URL string.
    func encodeURLWhiteSpaces(with urlString: String) -> String? {
        var imageURLString = ""
        if urlString.contains(" ") {
            guard let validImageString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                print("Cannot add a %20 to an empty space in a url string.")
                return nil
            }
            imageURLString = validImageString
        }
        return imageURLString
    }
    
    /// String is an Int validation
    var isInt: Bool {
        return Int(self) != nil
    }
    
    /// Get String value before the delimiter
    func before(first delimiter: Character) -> String {
            if let index = firstIndex(of: delimiter) {
                let before = prefix(upTo: index)
                return String(before)
            }
            return ""
        }
       
    /// Get String value after the delimiter
    func after(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let after = suffix(from: index).dropFirst()
            return String(after)
        }
        return ""
    }
    
    /// Get website domain from an URL.
    func getWebsiteDomainFrom() -> String {
        let url = URL(string: self)
        guard let domain = url?.host else {return "error"}
        var modifiedDomain: String = ""
        var checkWWW: String = ""
        let checkIndexes = [0,1,2,3]
        for (index,char) in domain.enumerated() {
            if checkIndexes.contains(index){
                checkWWW.append(char)
            }
            if index > 3 && checkWWW.lowercased() == "www."  {
                modifiedDomain.append(char)
            }
        }
        if checkWWW.lowercased() == "www."{
            return modifiedDomain
        }
        else {
            return domain
        }
    }
    
    /// Get date and time with am/pm as well.
    func getDateTime() -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "hh:mm:ss a"
            let timeStr = formatter.string(from: date)
            formatter.dateFormat = "yyyy-MM-dd"
            let dateStr = formatter.string(from: date)
            return "\(dateStr) | \(timeStr)"
        }
        return nil
    }
    
    /// Get date
    func getDate() -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "hh:mm:ss a"
            formatter.dateFormat = "yyyy-MM-dd"
            let dateStr = formatter.string(from: date)
            return dateStr
        }
        return nil
    }
    
}
