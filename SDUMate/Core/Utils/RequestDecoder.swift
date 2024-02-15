//
//  RequestDecoder.swift
//  BePRO
//
//  Created by Sanzhar Dauylov on 24.01.2024.
//

import Moya
import Foundation

public class RequestDecoder {
    public static let shared = RequestDecoder()

    public init() {}

    public func decodeResult<T: Codable>(_ result: Result<Response, MoyaError>,
                                         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
                                         completion: @escaping (Result<T, NetworkError>) -> Void) {
        jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
        switch result {
        case .success(let response):
            do {
                let decodedData = try jsonDecoder.decode(T.self, from: response.data)
                completion(.success(decodedData))
            } catch {
                dump(error)
                if let errorResponse = try? JSONDecoder().decode(BaseError.self, from: response.data) {
                    completion(.failure(validateOnErrors(error, response: response.response, baseError: errorResponse)))
                }
                completion(.failure(validateOnErrors(error, response: response.response)))
            }
        case .failure(let error):
            completion(.failure(.moyaError(error)))
        }
    }
    
    public func decodeSuccessResult(_ result: Result<Response, MoyaError>,
                                    completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        switch result {
        case .success(let response):
            do {
                try response.filterSuccessfulStatusCodes()
                completion(.success(true))
            } catch let error {
                dump(error)
                if let errorResponse = try? JSONDecoder().decode(BaseError.self, from: response.data) {
                    completion(.failure(.base(errorResponse)))
                }
                completion(.failure(.errorWithCode(description: "Error response decode error. Error: \(error)")))
            }
        case .failure(let error):
            completion(.failure(.moyaError(error)))
        }
    }

    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private func validateOnErrors(_ error: Error, response: HTTPURLResponse?, baseError: BaseError? = nil) -> NetworkError {
        guard let response = response else { return .unsupportedError }
        let message = error.localizedDescription
        let statusCode = response.statusCode
        switch statusCode {
        case 400:
            if let baseError = baseError {
                return .invalidRequest(baseError.description)
            }
            return .invalidRequest("invalid_error")
        case 401:
//            DeeplinkService.shared.reloadMainTabBar(with: .notAuthorized)
            if let baseError = baseError {
                return .authProblem(baseError.description)
            }
            return .authProblem("auth_problem")
        case 403:
            return .accessProblem(code: statusCode, message: message, url: response.url?.absoluteString)
        case _ where statusCode >= 500:
            return .serverError(code: statusCode, message: message, url: response.url?.absoluteString)
        default:
            if let baseError = baseError {
                return .invalidRequest(baseError.description)
            }
            return .unsupportedError
        }
    }
}

public enum NetworkError: Error {
    case decodeFailure
    case moyaError(_ error: MoyaError)
    case jiraTokenMissed
    case errorWithCode(code: String? = nil, description: String)
    case invalidRequest(String)
    case base(BaseError)
    case authProblem(String)
    case accessProblem(code: Int, message: String, url: String? = nil)
    case serverError(code: Int, message: String, url: String? = nil)
    case notFound(code: Int, message: String, url: String? = nil)
    case serverIsNotAvaivable(code: Int, message: String, url: String? = nil)
    case jsonParsingError(json: String, url: String? )
    case error
    case unsupportedError
    
    public var description: String {
        switch self {
        case .base(let error): return error.description // error.code + ": " +
        case .decodeFailure: return "Decode error"
        case .jiraTokenMissed: return "Jira token missed"
        case .moyaError(let error): return "Network error: \(error.errorDescription ?? "")"
        case .errorWithCode(let code, let descr):
            guard let code = code else {
                return  "Message: \(descr)"
            }
            return  "Message: \(descr) Code: \(code)"
        case .authProblem(let error):
            return error
        case .accessProblem(_, let message, _):
            return message
        case .serverError(_, let message, _):
            return message
        case .notFound(_, let message, _):
            return message
        case .serverIsNotAvaivable(_, let message, _):
            return message
        case .jsonParsingError(_, _):
            return "error_standard"
        case .error:
            return "error_standard"
        case .unsupportedError:
            return "error_standard"
        case .invalidRequest(let descr):
            return descr
        }
    }
    
    public var localizedDescription: String {
        return description
    }
}

public struct BaseError: Codable {
    public let code: Int
    public let description: String
}
