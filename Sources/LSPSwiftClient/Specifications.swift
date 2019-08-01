typealias Specifications = LSPMessage
public extension Specifications {
    static func openDocument(at path: String) -> OpenDocumentNotification {
        return OpenDocumentNotification(path: path)
    }

    static func completion(atLine: Int, character: Int, in path: String) {}
}