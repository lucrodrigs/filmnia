//
//  TaskExecutor.swift
//  filmnia
//
//  Created by UserTQI on 15/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

protocol TaskExecutor {
    func execute(url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension TaskExecutor {
    
    func execute(url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
    
}

class Executor: TaskExecutor {}

class MockExecutor: TaskExecutor {
    
}
