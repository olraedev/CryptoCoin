//
//  NetworkCheck.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/2/24.
//

import Foundation
import Network

final class NetworkCheck {
    static let shared = NetworkCheck()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    var isConnected = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            // 인터넷 연결이 원활한 경우
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
