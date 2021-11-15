//
//  URLSessionDataTaskMock.swift
//  EamDataTests
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}
