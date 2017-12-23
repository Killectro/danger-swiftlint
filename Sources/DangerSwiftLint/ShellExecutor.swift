import Foundation

internal class ShellExecutor {
    func execute(_ command: String, arguments: String...) -> String {
        let script = "\(command) \(arguments.joined(separator: " "))"
        print("Executing \(script)")

        var env = ProcessInfo.processInfo.environment
        let task = Process()
        task.launchPath = env["SHELL"]
        task.arguments = ["-l", "-c", script]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: String.Encoding.utf8)!
    }
}
