import Foundation

enum OptionType: String {
    case palindrome = "p"
    case anagram = "a"
    case help = "h"
    case quit = "q"
    case unknown
    
    init(value: String) {
        switch value {
        case "a": self = .anagram
        case "p": self = .palindrome
        case "h": self = .help
        case "q": self = .quit
        default: self = .unknown
        }
    }
}

class Panagram {
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        let (option, value) = getOption(
            argument.substring(
                from: argument.index(argument.startIndex, offsetBy: 1)
            )
        )
        
        switch option {
        case .anagram:
            if argCount != 4 {
                if argCount < 4 {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                }
            } else {
                let first = CommandLine.arguments[2]
                let second = CommandLine.arguments[3]
                
                if first.isAnagramOf(second) {
                    consoleIO.writeMessage("\(second) is an anagram of \(first)")
                } else {
                    consoleIO.writeMessage("\(second) is not an anagram of \(first)")
                }
            }
        case .palindrome:
            if (argCount != 3) {
                consoleIO.writeMessage("Invalid number of arguments", to: .error)
            } else {
                let word = CommandLine.arguments[2]
                
                if word.isPalindrome() {
                    consoleIO.writeMessage("\(word) is palindrome")
                } else {
                    consoleIO.writeMessage("\(word) is not palindrome")
                }
            }
        case .help:
            consoleIO.printUsage()
        case .unknown, .quit:
            consoleIO.writeMessage("Unknown option \(value)")
            consoleIO.printUsage()
        }
    }
    
    func interactiveMode() {
        consoleIO.writeMessage("Welcome to Panagram. This program checks if an input string is an anagram or palindrome")
        
        var shouldQuit = false
        
        while !shouldQuit {
            consoleIO.writeMessage("Type 'a' for anagrams, 'p' for palidromes or 'q' for quit.")
            
            let (option, _) = getOption(consoleIO.getInput());
            
            switch option {
            case .anagram:
                consoleIO.writeMessage("Enter first word: ")
                let first = consoleIO.getInput()
                consoleIO.writeMessage("Enter second word: ")
                let second = consoleIO.getInput()
                
                if (first.isAnagramOf(second)) {
                    consoleIO.writeMessage("\(second) is an anagram of \(first)")
                } else {
                    consoleIO.writeMessage("\(second) is not an anagram of \(first)")
                }
            case .palindrome:
                consoleIO.writeMessage("Enter word: ")
                let word = consoleIO.getInput()
                
                if word.isPalindrome() {
                    consoleIO.writeMessage("\(word) is palindrome")
                } else {
                    consoleIO.writeMessage("\(word) is not palindrome")
                }
            case .quit:
                shouldQuit = true
            default:
                consoleIO.writeMessage("Unknown option.", to: .error)
            }
        }
    }
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }
}
