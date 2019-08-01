import Foundation

public final class Server {
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
}

public extension Server {
    func send<T, Request, Response>(message: T, completion: @escaping (Result<Response, LSPError>) -> Void) where T: LSPMessage<Request, Response> {
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