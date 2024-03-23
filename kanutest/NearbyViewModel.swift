//
//  NearbyViewModel.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import Foundation
import Combine
import NearbyInteraction

class NearbyViewModel: ObservableObject {
    
    private var nearbyManager = NearbyManager()
    @Published private(set) var isNearbySessionEstablished: Bool = false
    @Published private(set) var distanceToPeerDevice: Float = 0.0
    private var cancellables = Set<AnyCancellable>()
    
    init() {
//        self.nearbyManager = nearbyManager
        self.bindToNearbyManager()
    }
    
    func startNearbySession() {
        self.nearbyManager.startNearbyInteractionSession()
    }
    
    func stopNearbySession() {
        self.isNearbySessionEstablished = false
        self.nearbyManager.sessionInvalidate()
    }
    
    func initiateNearbySession() {
        self.nearbyManager.initiateNearbySession()
    }
    
    func getLocalDiscoveryToken() -> NIDiscoveryToken? {
        return self.nearbyManager.localDiscoveryToken
    }
    
    func setPeerDiscoveryToken(token: NIDiscoveryToken) {
        self.nearbyManager.setPeerDiscoveryToken(token)
    }
}


private extension NearbyViewModel {
    func bindToNearbyManager() {
        self.nearbyManager.$updatedNearbyObject
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] nearbyObject in
                self?.updateDistanceToPeerDevice(with: nearbyObject)
            }.store(in: &self.cancellables)
        
        self.nearbyManager.sessionEstablished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.isNearbySessionEstablished = true
            }.store(in: &self.cancellables)
    }
    
    func updateDistanceToPeerDevice(with nearbyObject: NINearbyObject) {
        self.distanceToPeerDevice = nearbyObject.distance ?? 0.0
    }
}
