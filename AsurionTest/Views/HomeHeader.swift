//
//  HomeHeader.swift
//  AsurionTest
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class HomeHeader: UIView{
    
    let chatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Chat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let callButton: UIButton = {
        let button = UIButton()
        button.setTitle("Call", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let workHoursLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.5
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .white
        buttonsStackView.addArrangedSubview(chatButton)
        buttonsStackView.addArrangedSubview(callButton)
        let mainStackView = UIStackView(arrangedSubviews: [buttonsStackView, workHoursLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        NSLayoutConstraint.activate([callButton.heightAnchor.constraint(equalToConstant: 50), chatButton.heightAnchor.constraint(equalToConstant: 50), workHoursLabel.heightAnchor.constraint(equalToConstant: 50), mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16), mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16), separator.bottomAnchor.constraint(equalTo: bottomAnchor), separator.heightAnchor.constraint(equalToConstant: 0.5), separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
    }
    
    func configure(settings: Settings) {
        workHoursLabel.text = "Office Hours: " + settings.workHours
        if settings.isChatEnabled {
            chatButton.isHidden = false
        } else {
            chatButton.isHidden = true
        }
        if settings.isCallEnabled {
            callButton.isHidden = false
        } else {
            callButton.isHidden = true
        }
        if settings.isChatEnabled == false && settings.isCallEnabled == false {
            buttonsStackView.isHidden = true
        }
    }
}
