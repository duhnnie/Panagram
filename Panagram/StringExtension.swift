import Foundation

extension String {
    func isAnagramOf(_ s: String) -> Bool {
        let lowerSelf = self.lowercased().replacingOccurrences(of: " ", with: "")
        let lowerOther = s.lowercased().replacingOccurrences(of: " ", with: "")
        
        return lowerSelf.sorted() == lowerOther.sorted()
    }
    
    func isPalindrome() -> Bool {
        let lowerSelf = self.lowercased().replacingOccurrences(of: " ", with: "")
        
        return lowerSelf == String(lowerSelf.reversed())
    }
}
