//
//  WebView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import Foundation
import SwiftUI
import Combine
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    @ObservedObject var viewModel: WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self.makeCoordinator(), name: "navigate")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.isScrollEnabled = false
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        var sessionID: AnyCancellable? = nil
        var foo: AnyCancellable? = nil
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }

        deinit {
            sessionID?.cancel()
            foo?.cancel()
        }
    }
}

extension WebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "navigate" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
            if let messageInString = message.body as? String {
                let messageInArray = messageInString.components(separatedBy: "/")
                let command = messageInArray[0]
                let data = messageInArray[1]
                
                if command == "profile" {
                    self.parent.viewModel.profileSheetData.send(data)
                    self.parent.viewModel.profileSheet.send(true)
                } else if command == "matching" {
                    self.parent.viewModel.matchingStackViewData.send(data)
                    self.parent.viewModel.matchingStackView.send(true)
                    NotificationCenter.default.post(name: NSNotification.Name("matchingStackView"), object: data, userInfo: nil)
                } else if command == "message" {
                    NotificationCenter.default.post(name: NSNotification.Name("messageStackView"), object: data, userInfo: nil)
                }
            }
        }
    }
}
