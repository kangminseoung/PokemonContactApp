//
//   InventoryTableViewCell.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit

class InventoryTableViewCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview().offset(-10)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.centerY.equalToSuperview().offset(10)
        }
    }
    
    func configure(name: String, phoneNumber: String, imageUrl: String?) {
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber

        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            loadImage(from: url)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle")
        }
    }
    
    private func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(systemName: "person.circle")
                }
            }
        }
    }
}
