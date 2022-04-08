//
//  Store.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import Foundation


typealias Subscription = NSObjectProtocol

class Store{
    private enum NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }
    
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register { action in
            self.onDispatch(action)
        }
    }()
    
    private let notificationCenter: NotificationCenter
    private let dispatcher:Dispatcher
    
    init(dispatcher: Dispatcher){
        self.dispatcher = dispatcher
        self.notificationCenter = NotificationCenter()
        _ = dispatchToken
    }
    
    func onDispatch(_ action:Action){
        fatalError("must overrided")
    }
    
    final func emitChange(){
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }
    
    final func addListener(callback: @escaping ()->()) -> Subscription{
        let using: (Notification) -> () = { notification in
            if notification.name == NotificationName.storeChanged{
                callback()
            }
        }
        return notificationCenter.addObserver(forName: NotificationName.storeChanged, object: nil, queue: nil, using: using)
    }
    
    final func removeListener(_ subscription:Subscription){
        notificationCenter.removeObserver(subscription)
    }
}
