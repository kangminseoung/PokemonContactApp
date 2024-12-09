//
//   InventoryTableView.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit

class InventoryTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private var pokemonCell: [(name: String, phoneNumber: String)] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        dataSource = self
        delegate = self
        register(InventoryTableViewCell.self, forCellReuseIdentifier: "InventoryCell") // 셀 클래스 등록
        rowHeight = 80 // 셀 높이
    }
    
    func configure(with pokemons: [(name: String, phoneNumber: String)]) {
        self.pokemonCell = pokemons
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as? InventoryTableViewCell else {
            return UITableViewCell()
        }
        let pokemon = pokemonCell[indexPath.row]
        cell.configure(name: pokemon.name, phoneNumber: pokemon.phoneNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemonCell[indexPath.row]
        print("선택된 포켓몬: \(pokemon.name), 전화번호: \(pokemon.phoneNumber)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
