//
//  Dispatcher.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import Foundation

typealias DispatchToken = String

final class Dispatcher {
    static let shared = Dispatcher()
    
    let lock: NSLocking
    private var callbacks: [DispatchToken: (Action) -> ()]
    
    private init(){
        self.lock = NSRecursiveLock()
        self.callbacks = [:]
    }
    deinit{
        print("deinit")
    }
    
    func register(callback: @escaping (Action)->())->DispatchToken{
        lock.lock(); defer {lock.unlock()}
        
        let token = UUID().uuidString
        callbacks[token] = callback
        return token
    }
    
    func unregister(token:DispatchToken){
        lock.lock(); defer {lock.unlock()}
        
        callbacks.removeValue(forKey: token)
    }
    func dispatch(_ action: Action){
        lock.lock(); defer {lock.unlock()}
        
        callbacks.forEach { _,callback in
            callback(action)
        }
    }
}
