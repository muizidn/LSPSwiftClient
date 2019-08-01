public class OpenDocumentNotification: LSPMessage<OpenDocumentNotification.Request, OpenDocumentNotification.Void> {
    public struct Request: Codable {
        let path: String
    }
    public struct Void: Codable {}

    override var request: OpenDocumentNotification.Request {
        return impl
    }

    private let impl: Request
    init(path: String) {
        impl = Request(path: path)
    }
}