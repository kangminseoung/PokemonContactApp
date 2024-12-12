//
//  PhoneBookView.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit


// Delegate 프로토콜 정의
protocol PhoneBookViewControllerDelegate: AnyObject {
    func didAddContact(name: String, phoneNumber: String)
}

class PhoneBookViewController: UIViewController {
    
    // Delegate 프로퍼티 정의
    weak var delegate: PhoneBookViewControllerDelegate?
    
    // UI 요소
    private let profileImageView = UIImageView() // 프로필 이미지를 표시할 이미지 뷰
    private let nameTextField = UITextField() // 이름 입력을 위한 텍스트 필드
    private let phoneNumberTextField = UITextField() // 전화번호 입력을 위한 텍스트 필드
    private let randomImageButton = UIButton(type: .system) // 랜덤 이미지를 생성하는 버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "연락처 추가" // 네비게이션 바 제목 설정
        
        // 네비게이션 바 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "적용", // 버튼 텍스트 설정
            style: .done, // 버튼 스타일 설정
            target: self, // 버튼 액션 타켓
            action: #selector(applyButtonTapped) // 버튼 클릭 시 실행할 메서드
        )
        
        // 프로필 이미지 뷰 설정
        profileImageView.contentMode = .scaleAspectFit // 이미지 비율을 유지하며 맞춤
        profileImageView.layer.cornerRadius = 75 // 둥근 모서리 설정
        profileImageView.layer.masksToBounds = true // 이미지가 뷰 경계를 넘지 않도록 설정
        profileImageView.layer.borderWidth = 1 // 테두리 두께 설정
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
        view.addSubview(profileImageView) // 뷰에 프로필 이미지 뷰 추가
        
        // 프로필 이미지 뷰의 레이아웃 설정
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30) // 상단에서 30만큼 떨어지게 설정
            $0.centerX.equalToSuperview() // 수평 중앙 정렬
            $0.width.height.equalTo(150) // 가로, 세로 크기 150 설정
        }
        
        // 랜덤 이미지 버튼 설정
        randomImageButton.setTitle("랜덤 이미지 생성", for: .normal) // 버튼 텍스트 설정
        randomImageButton.setTitleColor(.systemBlue, for: .normal) // 버튼 텍스트 색상 설정
        randomImageButton.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchUpInside) // 클릭 시 이벤트 설정
        view.addSubview(randomImageButton) // 뷰에 랜덤이미지 버튼 추가
        
        // 랜덤 이미지 버튼 레이아웃 설정
        randomImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(10) // 프로필 하단에서 10만큼 떨어지게 설정
            $0.centerX.equalToSuperview() // 수평 중앙 정렬
        }
        
        // 이름 입력 필드 설정
        nameTextField.placeholder = "이름" // 이름 필드의 힌트 텍스트 설정
        nameTextField.borderStyle = .roundedRect // 테두리 스타일 설정
        view.addSubview(nameTextField) // 뷰에 이름 입력 필드 추가
        
        // 이름 입력 필드의 레이아웃 설정
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(randomImageButton.snp.bottom).offset(20) // 랜덤 이미지 버튼 하단에서 20만큼 떨어지게 설정
            $0.leading.trailing.equalToSuperview().inset(20) // 좌우에서 20만큼 떨어지게 설정
            $0.height.equalTo(40) // 높이 40으로 설정
        }
        
        // 전화번호 입력 필드 설정
        phoneNumberTextField.placeholder = "전화번호" // 전화번호 필드의 힌트 텍스트 설정
        phoneNumberTextField.borderStyle = .roundedRect // 테두리 스타일 설정
        view.addSubview(phoneNumberTextField) // 뷰에 전화번호 입력 필드 추가
        
        // 전화번호 입력 필드 레이아웃 설정
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20) // 이름 입력 필드 하단에서 20만큼 떨어지게 설정
            $0.leading.trailing.equalToSuperview().inset(20) // 좌우에서 20만큼 떨어지게 설정
            $0.height.equalTo(40) // 높이 40으로 설정
        }
    }
    
    // 랜덤 이미지 버튼 클릭 시 호출되는 메서드
    @objc
    private func randomImageButtonTapped() {
        PokemonAPIManager.shared.pokemonData { [weak self] Pokemon in
            guard let self = self else { return } // self가 nil이면 종료
            guard let pokemon = Pokemon else { // 포켓몬 데이터를 가져오지 못한 경우
                return
            }
            
            DispatchQueue.main.async { // 메인 스레드에서 UI 업데이트
                self.nameTextField.text =  pokemon.name.capitalized // 포켓몬 이름 설정
                self.phoneNumberTextField.text = self.randomPhoneNumber() // 랜덤 전화번호 생성 후 설정
                
                if let imageUrlString = pokemon.sprites.frontDefault, // 포켓몬 이미지 URL이 있는 경우
                   let imageUrl = URL(string: imageUrlString) { // URL 변환 성공
                    self.loadImage(from: imageUrl) // 이미지 로드 메서드 호출
                } else {
                    self.profileImageView.image = UIImage(systemName: "person.circle") // 기본 이미지 설정
                }
            }
        }
    }
    
  
    // 전화번호 랜덤 생성하는 메서드
    private func randomPhoneNumber() -> String {
        let first = Int.random(in: 1000...9999) // 4자리 랜덤 숫자 생성
        let second = Int.random(in: 1000...9999) // 4자리 랜덤 숫자 생성
        return "010-\(first)-\(second)"
    }
    
    // URL에서 이미지 로드하는 메서드
    private func loadImage(from url: URL) {
        
        DispatchQueue.global().async { // 비동기 작업
            if let data = try? Data(contentsOf: url), // URL에서 데이터 가져옴
                let image = UIImage(data: data) { // 데이터 UIImage로 변환
                DispatchQueue.main.async { // 메인 스레드에서 UI 업데이트
                    self.profileImageView.image = image // 프로필 이미지 뷰에 이미지 설정
                }
            }
        }
    }
    
    

    @objc private func applyButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            print("이름과 전화번호를 입력해야 합니다.")
            return
        }

        // Delegate 호출로 데이터 전달
        delegate?.didAddContact(name: name, phoneNumber: phoneNumber)
        navigationController?.popViewController(animated: true)
    }
}
