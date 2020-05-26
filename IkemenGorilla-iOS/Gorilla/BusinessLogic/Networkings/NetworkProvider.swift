//
//  NetworkProvider.swift
//  Gorilla
//
//  Created by admin on 2020/05/26.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

final class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
    init() {
        let plugins: [PluginType] = [
            LoggerPlugin()
        ]
        super.init(plugins: plugins)
    }
}
