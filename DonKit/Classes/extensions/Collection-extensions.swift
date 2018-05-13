public extension Collection {

    func jsonString(prettyPrinted: Bool = true) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: prettyPrinted ? [.prettyPrinted] : [])
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Can't create string with data.")
                return nil
            }
            return jsonString
        } catch let parseError {
            print("json serialization error: \(parseError)")
            return nil
        }
    }
}
