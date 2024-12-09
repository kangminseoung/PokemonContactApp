//
//   InventoryTableViewCell.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit

class InventoryTableViewCell: UITableViewCell {
    
    private let profileImageView: UIImageView = { // 프로필 이미지를 표시하기 위해서 UIImageView 사용
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // 비율을 유지하면서 뷰에 맞춘다.
        imageView.layer.cornerRadius = 30 // 이미지의 둥근 모서리 설정
        imageView.layer.borderWidth = 1 // 테두리 두께 설정
        imageView.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
        imageView.clipsToBounds = true // 뷰를 벗어난 콘텐츠 잘라내기
        return imageView
    }()
    
    // 포켓몬 이름 UILabel 속성 설정
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15) // 시스템 폰트 크기 설정
        label.textColor = .black // 텍스트 색상 설정
        return label
    }()
    
    // 전화번호 UILabel 속성 설정
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18) // 시스템 폰트 크기 설정
        label.textColor = .black // 텍스트 색상 설정
        return label
    }()
    
    // 초기화 메서드 : 코드로 셀을 생성할 때 호출
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // UI 구성 메서드 호출
    }
    
    // 인터페이스 빌더를 사용할 경우 이 초기화 메서드는 구현되지 않음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // 사용 않됨을 표시.
    }
    
    // 셀 UI 구성하는 메서드
    private func setupUI() {
        
        contentView.addSubview(profileImageView) // 프로필 이미지 추가
        contentView.addSubview(nameLabel) // 이름 레이블 추가
        contentView.addSubview(phoneNumberLabel) // 전화번호 레이블 추가
        
        // 프로필 이미지 레이아웃 설정
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16) // 왼쪽에서 16 설정
            $0.centerY.equalToSuperview() // 수직 중앙에 정렬
            $0.width.height.equalTo(60) // 가로, 세로 크기 60
        }
        
        // 이름 레이블 레이아웃 설정
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.leading).offset(100) // 프로필 이미지 기준으로 오른쪽으로 100
            $0.centerY.equalTo(profileImageView.snp.centerY) // 수직 중앙 정렬
            $0.width.height.equalTo(80) // 가로, 세로 크기 80
        }
        
        // 전화번호 레이블 레이아웃 설정
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading).offset(120) // 이름 레이블 기준으로 오른쪽으로 100
            $0.centerY.equalTo(profileImageView.snp.centerY) // 수직 중앙 정렬
            $0.width.equalTo(200) // 가로 크기 200
        }
    }
    
    // 셀 데이터를 업데이트 하는 메서드
    func configure(name: String, phoneNumber: String) {
        profileImageView.image = UIImage(systemName: "person.circle") // 기본 프로필 이미지 설정
        nameLabel.text = name // 이름 레이블에 텍스트 설정
        phoneNumberLabel.text = phoneNumber // 전화번호 레이블에 텍스트 설정
    }
}


#Preview("MainViewController") {
    MainViewController()
}
