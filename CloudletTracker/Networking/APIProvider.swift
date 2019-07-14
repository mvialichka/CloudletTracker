//
//  APIProvider.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper
import enum Result.Result
import Moya
import Moya_ObjectMapper
import Alamofire

class APIProvider<Target> where Target: Moya.TargetType {
    private let provider: MoyaProvider<Target>
    private let tokenHolder: TokenHolder

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         tokenHolder: TokenHolder) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     manager: manager,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
        self.tokenHolder = tokenHolder
    }

    @discardableResult
    func request(_ target: Target, completion: @escaping Moya.Completion) -> Cancellable {
        return provider.request(target, completion: completion)
    }

    @discardableResult
    func request<Entity>(_ target: Target,
                         retry: Bool = false,
                         completion: @escaping (_ result: Result<Entity, MoyaError>) -> Void) -> Cancellable
        where Entity: BaseMappable {
            return request(target) { (result: Result<Response, MoyaError>) in
                let result: Result<Entity, MoyaError> = self.transform(result: result)
                completion(result)
            }
    }

    static func cloudletTrackerNetworking<T>(tokenHolder: TokenHolder) -> APIProvider<T>
        where T: TargetType {
            let plugins = [NetworkLoggerPlugin(verbose: true)]
            let provider = APIProvider<T>(
                endpointClosure: APIProvider.endpointsClosure(tokenHolder),
                requestClosure: MoyaProvider<T>.defaultRequestMapping,
                stubClosure: MoyaProvider.neverStub,
                plugins: plugins,
                trackInflights: false,
                tokenHolder: tokenHolder
            )
            return provider
    }


    static func endpointsClosure<T>(_ tokenHolder: TokenHolder? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint: Endpoint = Endpoint(
                url: url(target, tokenHolder: tokenHolder),
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
            return endpoint
        }
    }
}

private extension APIProvider {
    private func transform<T>(result: Result<Response, MoyaError>) -> Result<T, MoyaError> where T: BaseMappable {
        return result
            .flatMap({ (response) -> Result<T, MoyaError> in
                guard let entity = try? response.mapObject(T.self) else {
                    return .failure(MoyaError.jsonMapping(response))
                }
                return .success(entity)
            })
    }
}

func url(_ route: TargetType, tokenHolder: TokenHolder?) -> String {
    var url = route.baseURL.appendingPathComponent(route.path).absoluteString
    guard
        let tokenHolder = tokenHolder,
        let token = tokenHolder.token else {
        return url
    }
    url.append("?APPID=\(token)")
    return url
}

extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
