//
//  ViewController.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate {
    
    
    // 타이틀 레이블 : 화면 상단의 "친구 목록" 표시
    private let titleLabel = UILabel()
    
    // 추가 버튼 : 새로운 항목을 추가하는 버튼
    private let addButton = UIButton(type: .system)
    
    // 테이블 뷰 : 친구 목록을 표시하는 테이블 뷰
    private let inventoryTableView = InventoryTableView()
    
    private var contacts: [PokemonEntity] = []
    
    // 초기 데이터 : 포켓몬 이름과 전화번호로 구성된 배열
    private let pokemonCell = [
        (name: "포켓몬 1", phoneNumber: "010-0000-0000"),
        (name: "포켓몬 2", phoneNumber: "010-2222-2222"),
        (name: "포켓몬 3", phoneNumber: "010-3333-3333"),
        (name: "포켓몬 4", phoneNumber: "010-4444-4444"),
        (name: "포켓몬 5", phoneNumber: "010-5555-5555")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        inventoryTableView.configure(with: pokemonCell) // 테이블 뷰에 데이터 설정
        fetchContacts()

    }
    
    private func setupUI() {
        view.backgroundColor = .white // 배경색 설정
        
        // 타이틀 레이블 설정
        titleLabel.text = "친구 목록" // 텍스트 설정
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold) // 폰트 크기 및 굵기 설정
        titleLabel.textAlignment = .center // 텍스트 정렬 설정
        view.addSubview(titleLabel) // 뷰에 타이틀 레이블 추가
        
        // 타이틀 레이블 레이아웃 설정
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-2) // 상단에서 10
            $0.centerX.equalToSuperview() // 수평 중앙 정렬
        }
        
        // 추가 버튼 설정
        addButton.setTitle("추가", for: .normal) // 버튼 텍스트 설정
        addButton.setTitleColor(.systemBlue, for: .normal) // 텍스트 색상 설정
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold) // 폰트 크기 및 굵기 설정
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside) // 버튼 액션 설정
        view.addSubview(addButton) // 뷰에 버튼 추가
        
        // 추가 버튼 레이아웃 설정
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel) // 타이틀 레이블과 수직 정렬
            $0.trailing.equalToSuperview().inset(20) // 오른쪽으로 20
        }
        
        // 테이블 뷰 추가
        view.addSubview(inventoryTableView)
        
        // 테이블 뷰 레이아웃 설정
        inventoryTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30) // 타이틀 레이블 하단에서 10
            $0.left.right.bottom.equalToSuperview() // 좌우 및 하단에 고정
        }
        inventoryTableView.delegate = inventoryTableView
    }

    private func fetchContacts() {
        // CoreData에서 연락처 데이터를 가져옴
        contacts = CoreDataManager.shared.fetchContacts()
        let data = contacts.map { ($0.name ?? "", $0.phoneNumber ?? "") }
        inventoryTableView.configure(with: data)
    }

    @objc private func addButtonTapped() {
        let phoneBookVC = PhoneBookViewController()
        phoneBookVC.delegate = self
        navigationController?.pushViewController(phoneBookVC, animated: true)
    }
}

// ChatGPT 사용했습니다.
extension MainViewController: PhoneBookViewControllerDelegate {
    func didAddContact(name: String, phoneNumber: String) {
        CoreDataManager.shared.createContact(name: name, phoneNumber: phoneNumber, imageURL: nil)
        fetchContacts() // 연락처 추가 후 데이터를 다시 가져옴
    }
}

extension MainViewController: InventoryTableViewDelegate {
    func didDeleteContact(at indexPath: IndexPath) {
        // CoreData에서 삭제 처리
        let contactToDelete = contacts[indexPath.row]
        CoreDataManager.shared.deleteContact(contact: contactToDelete)
        
        // 데이터 동기화 및 테이블 뷰 갱신
        fetchContacts()
    }
}
