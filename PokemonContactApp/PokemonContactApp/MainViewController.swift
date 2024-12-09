//
//  ViewController.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let titleLabel = UILabel() // 타이틀 레이블
    private let addButton = UIButton(type: .system) // 추가 버튼
    private let inventoryTableView = InventoryTableView() // 테이블 뷰
    
    private let pokemonCell = [
        (name: "포켓몬 1", phoneNumber: "010-1111-1111"),
        (name: "포켓몬 2", phoneNumber: "010-2222-2222"),
        (name: "포켓몬 3", phoneNumber: "010-3333-3333"),
        (name: "포켓몬 4", phoneNumber: "010-4444-4444"),
        (name: "포켓몬 5", phoneNumber: "010-5555-5555")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        inventoryTableView.configure(with: pokemonCell)

    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // 타이틀 레이블 설정
        titleLabel.text = "친구 목록"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        // 타이틀 레이블 레이아웃 설정
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        // 추가 버튼 설정
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        // 추가 버튼 레이아웃 설정
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        // 테이블 뷰 추가
        view.addSubview(inventoryTableView)
        
        // 테이블 뷰 레이아웃 설정
        inventoryTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func addButtonTapped() {
        print("버튼 클릭됨")
    }
    
}
#Preview("MainViewController") {
    MainViewController()
}
