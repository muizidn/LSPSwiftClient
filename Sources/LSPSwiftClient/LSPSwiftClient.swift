import Foundation

public enum LSPError: Error {
    case documentOpened
    case error(Error)
}

public class LSPMessage<RPCRequest: Codable, RPCResponse: Codable> {
    var request: RPCRequest {
        fatalError()
    }
    func send(server: Server, request: RPCRequest, completion: @escaping (Result<RPCResponse, LSPError>) -> Void) {

    }
}

public class AnyMessage: LSPMessage<AnyMessage.Request, AnyMessage.Response> {
    public struct Request: Codable {
        let path: String
    }
    public struct Response: Codable {
        let id: String
    }

    override var request: AnyMessage.Request {
        return impl
    }

    private let impl: Request
    init(path: String) {
        impl = Request(path: path)
    }
    deinit { print("You have deinited") }
}

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

public extension LSPMessage {
    static func openDocument(at path: String) -> OpenDocumentNotification {
        return OpenDocumentNotification(path: path)
    }

    static func completion(atLine: Int, character: Int, in path: String) {}
}

public final class Server: Hashable {
    let executableURL: URL
    let projectURL: URL
    public init(exec: URL, project: URL) {
        executableURL = exec
        projectURL = project
    }

    public init?(execPath: String, projectPath: String) {
        guard let exec = URL(string: execPath) else { return nil }
        guard let project = URL(string: projectPath) else { return nil }
        executableURL = exec
        projectURL = project
    }

    public static func == (lhs: Server, rhs: Server) -> Bool {
        return lhs.executableURL == rhs.executableURL
            && lhs.projectURL == rhs.projectURL
            && lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(executableURL)
        hasher.combine(projectURL)
    }

    public func send<T, Request, Response>(message: T, completion: @escaping (Result<Response, LSPError>) -> Void) where T: LSPMessage<Request, Response> {
        let res: Result<Response, LSPError>
        do {
            let data = try JSONEncoder()
                .encode(message.request)
            let resp = try JSONDecoder()
                .decode(Response.self, from: data)
            res = .success(resp)
        } catch {
            res = .failure(.error(error))
        }
        completion(res)
    }
}
