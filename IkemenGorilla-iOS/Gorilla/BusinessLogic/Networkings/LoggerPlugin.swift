//
//  LoggerPlugin.swift
//  Gorilla
//
//  Created by admin on 2020/05/26.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

class LoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        let representation = request.request?.representation ?? ""
        logger.info("🚀 \(representation)")

        if let cURLString = request.request?.cURLRepresentation {
            logger.verbose(cURLString)
        }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            let representation = response.request?.representation ?? ""
            DispatchQueue.global(qos: .background).async {
                let emoji = 200 ..< 300 ~= response.statusCode ? "🎉" : "🌧"
                logger.info("\(emoji) \(response.statusCode) \(representation)")
            }
        case let .failure(error):
            logger.error(error)
        }
    }
}

private extension URLRequest {
    var representation: String? {
        guard let httpMethod = httpMethod else { return nil }
        guard let url = url?.absoluteString else { return nil }

        return "\(httpMethod) \(url)"
    }

    var cURLRepresentation: String? {
        guard let url = self.url else {
            return nil
        }

        var components: [String] = ["curl -v"]

        if let httpMethod = self.httpMethod, httpMethod != "GET" {
            components.append("-X \(httpMethod)")
        }

        var headers: [AnyHashable: Any] = [:]

        if let headerFields = self.allHTTPHeaderFields {
            for (field, value) in headerFields where field != "Accept-Encoding" {
                headers[field] = value
            }
        }

        for (field, value) in headers {
            components.append("-H \'\(field): \(value)\'")
        }

        if let body = httpBody, let string = String(data: body, encoding: .utf8) {
            components.append("-d \'\(string)\'")
        }

        components.append("\"\(url.absoluteString)\"")

        return """
        cURL snippet:
        ```
        \(components.joined(separator: " \\\n  ")) | jq .
        ```
        """
    }
}
