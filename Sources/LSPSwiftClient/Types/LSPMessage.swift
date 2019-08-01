public class LSPMessage<RPCRequest: Codable, RPCResponse: Codable> {
    var request: RPCRequest {
        fatalError()
    }
    func send(server: Server, request: RPCRequest, completion: @escaping (Result<RPCResponse, LSPError>) -> Void) {

    }
}