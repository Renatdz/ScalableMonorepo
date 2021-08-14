import Foundation

public extension URLRequest {
    func cURLDescription() -> String {
        guard
            let url = self.url,
            let method = self.httpMethod
            else {
                return "$ curl command could not be created"
        }
        
        var components = ["$ curl -v"]
        
        components.append("-X \(method)")
        
        for header in self.allHTTPHeaderFields ?? [:] {
            let escapedValue = header.value.replacingOccurrences(of: "\"", with: "\\\"")
            components.append("-H \"\(header.key): \(escapedValue)\"")
        }
        
        if let httpBodyData = self.httpBody {
            let httpBody = String(decoding: httpBodyData, as: UTF8.self)
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")
            
            components.append("-d \"\(escapedBody)\"")
        }
        
        components.append("\"\(url.absoluteString)\"")
        
        return components.joined(separator: " \\\n\t")
    }
}
