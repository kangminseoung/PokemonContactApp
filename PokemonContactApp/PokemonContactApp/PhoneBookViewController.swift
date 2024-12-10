//
//  PhoneBookView.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    // 프로필 이미지 표시
    private let profileImageView = UIImageView()
    
    // 이름 입력을 위한 텍스트 뷰
    private let nameTextView = UITextView()
    
    // 전화번호 입력을 위한 텍스트 뷰
    private let phoneNumberTextView = UITextView()
    
    // 랜덤 이미지를 생성하는 버튼
    private let randomImageButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white // 배경색 설정
        title = "연락처 추가" // 네비게션 바 제목 설정
        
        // 네비게이션 바의 오른쪽 버튼 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "적용", // 버튼 설정
            style: .done, // 버튼 스타일 설정
            target: self, // 버튼 이벤트 타겟
            action: #selector(applyButtonTapped) // 버튼 클릭 시 실행
        )
        
        // 프로필 이미지 뷰 설정
        profileImageView.contentMode = .scaleAspectFit // 이미지 비율 뷰에 맞춤
        profileImageView.image = UIImage(systemName: "person.circle") // 기본 이미지 설정
        profileImageView.layer.cornerRadius = 75 // 둥근 모서리 설정
        profileImageView.layer.masksToBounds = true // 이미지 뷰 경계 밖 내용 자르기
        profileImageView.layer.borderWidth = 1 // 테두리 두께 설정
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
        view.addSubview(profileImageView) // 뷰에 프로필 이미지 뷰 추가
        
        // 프로필 이미지 레이아웃 설정
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30) // 상단에서 30
            $0.centerX.equalToSuperview() // 수평 중앙 정렬
            $0.width.height.equalTo(150) // 가로 세로 크기 150
        }
        
        // 랜덤 이미지 버튼 설정
        randomImageButton.setTitle("랜덤 이미지 생성", for: .normal) // 버튼 제목 설정
        randomImageButton.setTitleColor(.black, for: .normal) // 버튼 텍스트 색상 설정
        randomImageButton.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchUpInside) // 클릭 시 이벤트 연결
        view.addSubview(randomImageButton) // 뷰에 랜덤이미지 버튼 추가
        
        // 랜덤 이미지 버튼 레이아웃 설정
        randomImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(10) // 프로필 이미지 하단에서 10
            $0.centerX.equalToSuperview() // 수평 중앙 정렬
        }
        
        // 이름 입력 텍스트 설정
        nameTextView.text = "" // 초기 텍스트
        nameTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 텍스트 내부 여백 설정
        nameTextView.layer.borderWidth = 1 // 테두리 두께 설정
        nameTextView.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
        nameTextView.font = UIFont.systemFont(ofSize: 16) // 폰트 크기 설정
        view.addSubview(nameTextView) // 뷰에 이름 텍스트 뷰 추가
        
        // 이름 텍스트 뷰 레이아웃 설정
        nameTextView.snp.makeConstraints {
            $0.top.equalTo(randomImageButton.snp.bottom).offset(20) // 랜덤 이미지 버튼 하단에서 20
            $0.leading.trailing.equalToSuperview().inset(20) // 좌우에서 20
            $0.height.equalTo(40) // 높이 설정
        }
        
        // 전화번호 텍스트 뷰 설정
        phoneNumberTextView.text = "" // 초기 텍스트
        phoneNumberTextView.layer.borderWidth = 1 // 테두리 두께 설정
        phoneNumberTextView.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
        phoneNumberTextView.font = UIFont.systemFont(ofSize: 16) // 폰트 크기 설정
        view.addSubview(phoneNumberTextView) // 뷰에 전화번호 텍스트 뷰 추가
        
        // 전화번호 텍스트 뷰 레이아웃 설정
        phoneNumberTextView.snp.makeConstraints {
            $0.top.equalTo(nameTextView.snp.bottom).offset(20) // 이름 텍스트뷰에서 20
            $0.leading.trailing.equalToSuperview().inset(20) // 좌우에서 20
            $0.height.equalTo(40) // 높이 설정
        }
    }
    
    // 랜덤 이미지 버튼 클릭 시 호출되는 메서드
    @objc
    private func randomImageButtonTapped() {
        
        // 프로필 이미지를 새로운 기본 이미지로 변경
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    // 네비게이션 바 "적용" 버튼 클릭 시 호출되는 메서드
    @objc
    private func applyButtonTapped() {
        
        print("버튼 클릭")
        
        // 이전화면 돌아가기
        navigationController?.popViewController(animated: true)
    }
}

#Preview("PhoneBookViewController") {
    PhoneBookViewController()
}
