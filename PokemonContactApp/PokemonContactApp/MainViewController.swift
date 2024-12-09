//
//  ViewController.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let titleLabel = UILabel()
    let TableView = UITableView()
    let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()

    }
    
    private func SetupUI() {
        // 배경 색상 하얀색 설정
        view.backgroundColor = .white
        
        // 테이블 뷰 레이아웃 설정
        view.addSubview(TableView)
        TableView.snp.makeConstraints {
            $0.edges.equalToSuperview() // 전체 화면 꽉 채움
        }
        
        // 레이블 속성 설정
        titleLabel.text = "친구 목록"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        // 레이블 레이아웃 설정
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        // 추가 버튼 설정
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.addSubview(addButton)
        
        // 추가 버튼 레이아웃 설정
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }

    }


}


#Preview("MainViewController") {
    MainViewController()
}
