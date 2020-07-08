//
//  PetInformationViewController.swift
//  AsurionTest
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit
import WebKit

class PetInformationViewController: UIViewController {
    
    var petInformation: Pet?
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setWebView()
        setNavigationBar()
    }
    
    func setLayout() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), webView.leadingAnchor.constraint(equalTo: view.leadingAnchor), webView.trailingAnchor.constraint(equalTo: view.trailingAnchor), webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func setNavigationBar() {
        navigationItem.title = petInformation?.title
    }
    
    func setWebView() {
        if let pet = petInformation {
            guard let url = URL(string: pet.contentUrl) else { return }
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
