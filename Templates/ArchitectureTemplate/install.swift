import Foundation

struct Constants {
    struct CommandLineValues {
        static let yes = "YES"
        static let no = "NO"
		
		static func from(_ input: String) -> String? {
			switch input.lowercased() {
			case "y", "yes", "s", "sim": 
				return CommandLineValues.yes
			case "n", "no", "nao", "nÃ£o": 
				return CommandLineValues.no
			default: 
				return nil
			}
		}
    }
	
    struct File {
        static let templateName = "VIP Scene.xctemplate"
        static let destinationRelativePath = "/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application"
    }

    struct Messages {
        static let successMessage = "â  Template was installed succesfully ð. Enjoy it ð"
        static let successfullReplaceMessage = "â  The Template has been replaced for you with the new version ð. Enjoy it ð"
        static let errorMessage = "â  Ooops! Something went wrong ð¡"
        static let exitMessage = "Bye Bye ð"
        static let promptReplace = "That Template already exists. Do you want to replace it? (YES or NO)"
    }

    struct Blocks {
        static let printSeparator = { print("====================================") }
    }
}

func printToConsole(_ message:Any) {
    Constants.Blocks.printSeparator()
    print("\(message)")
    Constants.Blocks.printSeparator()
}

func moveTemplate(){
    do {
        let fileManager = FileManager.default
        let destinationPath = bash(command: "xcode-select", arguments: ["--print-path"]).appending(Constants.File.destinationRelativePath)
        printToConsole("Template will be copied to: \(destinationPath)")
        
        if !fileManager.fileExists(atPath: "\(destinationPath)/\(Constants.File.templateName)") {
            try fileManager.copyItem(atPath: Constants.File.templateName, toPath: "\(destinationPath)/\(Constants.File.templateName)")
            printToConsole(Constants.Messages.successMessage)
        } else {
            print(Constants.Messages.promptReplace)
            var input: String?
            repeat {
                guard let textFormCommandLine = readLine(strippingNewline: true) else {
                    continue
                }
                input = Constants.CommandLineValues.from(textFormCommandLine)
            } while(input == nil)

            if input == Constants.CommandLineValues.yes {
                try replaceItemAt(URL(fileURLWithPath: "\(destinationPath)/\(Constants.File.templateName)"), withItemAt: URL(fileURLWithPath: Constants.File.templateName))
                printToConsole(Constants.Messages.successfullReplaceMessage)
            } else {
                print(Constants.Messages.exitMessage)
            }
        }
    }

    catch let error as NSError {
        printToConsole("\(Constants.Messages.errorMessage) : \(error.localizedFailureReason!)")
    }
}

func replaceItemAt(_ url: URL, withItemAt itemAtUrl: URL) throws {
    let fileManager = FileManager.default
    try fileManager.removeItem(at: url)
    try fileManager.copyItem(atPath: itemAtUrl.path, toPath: url.path)
}

func shell(launchPath: String, arguments: [String]) -> String {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)!
    if output.count > 0 {
        //remove newline character.
        let lastIndex = output.index(before: output.endIndex)
        return String(output[output.startIndex ..< lastIndex])
    }
    return output
}

func bash(command: String, arguments: [String]) -> String {
    let whichPathForCommand = shell(launchPath: "/bin/bash", arguments: [ "-l", "-c", "which \(command)" ])
    return shell(launchPath: whichPathForCommand, arguments: arguments)
}

moveTemplate()
