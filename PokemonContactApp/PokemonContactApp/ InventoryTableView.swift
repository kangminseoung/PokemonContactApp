//
//   InventoryTableView.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit

protocol InventoryTableViewDelegate: AnyObject {
    func didDeleteContact(at indexPath: IndexPath)
}


class InventoryTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    weak var inventoryDelegate: InventoryTableViewDelegate?
    
    // 포켓몬 데이터 저장 배열
    private var pokemonCell: [(name: String, phoneNumber: String)] = []
    
    // 초기화 메서드 : 코드로 테이블 뷰를 생성할 때 호출
    init() {
        super.init(frame: .zero, style: .plain)
        setupTableView() // 테이블 뷰 설정 호출
    }
    
    // 인터페이스 빌더를 사용할 경우 이 초기화 메서드는 구현되지 않음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        dataSource = self // 데이터 소스 설정
        delegate = self // 델리게이트 설정
        register(InventoryTableViewCell.self, forCellReuseIdentifier: "InventoryCell") // 셀 클래스 등록
        rowHeight = 80 // 셀 높이
    }
    
    // 외부에서 포켓몬 데이터를 설정하고 테이블 뷰를 갱신하는 메서드
    func configure(with pokemons: [(name: String, phoneNumber: String)]) {
        self.pokemonCell = pokemons
        reloadData()
    }
    
    // 데이터 소스 메서드 : 섹션당 행 수를 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonCell.count // 포켓몬 배열의 아이템 수 반환
    }
    
    // 데이터 소스 메서드 : 각 행의 셀을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 등록된 셀을 재사용 큐에서 가져옴
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as? InventoryTableViewCell else {
            return UITableViewCell() // 기본 셀 반환
        }
        
        // 현재 인덱스의 데이터를 가져와서 셀을 구성
        let pokemon = pokemonCell[indexPath.row]
        cell.configure(name: pokemon.name, phoneNumber: pokemon.phoneNumber)
        return cell
    }
    
    // 델리게이트 메서드 : 셀이 선택되었을 때 호출
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 선택된 포켓몬 데이터를 가져온다
        let pokemon = pokemonCell[indexPath.row]
        
        // 콘솔에 선택된 포켓몬 정보 출력
        print("선택된 포켓몬: \(pokemon.name), 전화번호: \(pokemon.phoneNumber)")
        
        // 선택된 셀의 선택 상태를 해제
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 스와이프 삭제 기능 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            
            // 내부 데이터 배열에서 삭제
            self.pokemonCell.remove(at: indexPath.row)
            
            // 테이블 뷰 갱신
            self.deleteRows(at: [indexPath], with: .fade)
            
            // Delegate를 통해 삭제 이벤트 전달
            self.inventoryDelegate?.didDeleteContact(at: indexPath)
            
            // 완료 처리
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
