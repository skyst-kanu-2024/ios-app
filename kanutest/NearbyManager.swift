//
//  NearbyManager.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import Foundation
import NearbyInteraction
import Combine
import UIKit

class NearbyManager: NSObject {
    private var session: NISession?
    private var peerDiscoveryToken: NIDiscoveryToken?
    private(set) var localDiscoveryToken: NIDiscoveryToken?
    @Published var updatedNearbyObject: NINearbyObject?
    let sessionEstablished: PassthroughSubject<Void, Never>
    
    override init() {
        self.sessionEstablished = PassthroughSubject()
        super.init()
        self.startNearbyInteractionSession()
    }
    
    func setPeerDiscoveryToken(_ discoveryToken: NIDiscoveryToken) {
        self.peerDiscoveryToken = discoveryToken
    }
    
    func initiateNearbySession() {
        guard let peerDiscoveryToken
        else { return }
        
        let configuration = NINearbyPeerConfiguration(peerToken: peerDiscoveryToken)
        self.session?.run(configuration)
        self.sessionEstablished.send()
    }
    
    func sessionInvalidate() {
        self.session?.invalidate()
    }
    
    func startNearbyInteractionSession() {
        self.sessionInvalidate()
        self.session = NISession()
        self.localDiscoveryToken = self.session?.discoveryToken
        self.setNearbyInteractionSessionDelegate()
    }
}

private extension NearbyManager {
    func setNearbyInteractionSessionDelegate() {
        self.session?.delegate = self
    }
}

extension NearbyManager: NISessionDelegate {
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        guard let peerDiscoveryToken
        else {
            fatalError("don't have peer token")
        }
        
        let peerObject = nearbyObjects.first { (object) -> Bool in
            return object.discoveryToken == peerDiscoveryToken
        }
        
        guard let updatedNearbyObject = peerObject
        else {
            return
        }
        
        self.updatedNearbyObject = updatedNearbyObject
    }
    
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        guard let peerDiscoveryToken =  self.peerDiscoveryToken
        else {
            fatalError("don't have peer token")
        }
        
        let peerObject = nearbyObjects.first { (object) -> Bool in
            return object.discoveryToken == peerDiscoveryToken
        }
        
        if peerObject == nil {
            return
        }
        
        switch reason {
        case .peerEnded:
            self.startNearbyInteractionSession()
        case .timeout:
            if let config = session.configuration {
                session.run(config)
            }
        default:
            fatalError("Unknown and unhandled NINearbyObject.RemovalReason")
        }
    }
    
    func sessionWasSuspended(_ session: NISession) {
        print("Session suspended")
    }
    
    func sessionSuspensionEnded(_ session: NISession) {
        if let configuration = self.session?.configuration {
            session.run(configuration)
        } else {
            self.startNearbyInteractionSession()
        }
    }
    
    func session(_ session: NISession, didInvalidateWith error: Error) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        
        guard let window = windowScene?.windows.first
        else { return }
        
        /// 근처 상호작용 권한이 설정되어있지 않은 경우
        if case NIError.userDidNotAllow = error {
            let accessAlertController = UIAlertController(title: "권한 요청",
                                                          message: """
                                                    주변에 있는 연인을 찾기 위해서는
                                                    로컬 네트워크 권한을 필요로 합니다.
                                                    설정 -> 개인정보 보호 및 보안 -> 로컬네트워크 에서
                                                    권한을 허용해주세요
                                                    """,
                                                          preferredStyle: .alert)
            accessAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            accessAlertController.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }))
            window.rootViewController?.present(accessAlertController, animated: true)
            return
        }
        self.startNearbyInteractionSession()
    }
}
