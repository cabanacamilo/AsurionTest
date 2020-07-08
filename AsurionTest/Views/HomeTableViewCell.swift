//
//  TableViewCell.swift
//  AsurionTest
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let petImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.borderWidth = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setLayout()
    }
    
    private func setLayout() {
        separatorInset.left = 16
        separatorInset.right = 16
        addSubview(petImage)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([petImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), petImage.centerYAnchor.constraint(equalTo: centerYAnchor), petImage.heightAnchor.constraint(equalToConstant: 80), petImage.widthAnchor.constraint(equalToConstant: 80), titleLabel.leadingAnchor.constraint(equalTo: petImage.trailingAnchor, constant: 10), titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor), titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
        petImage.layer.cornerRadius = 40
    }

    func configure(pet: Pet) {
        petImage.loadCacheImage(url: pet.imageUrl)
        titleLabel.text = pet.title
    }
}
