//
//  PokemonAPIManager.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/10/24.
//

import Foundation

struct Pokemon: Decodable {
    let name: String // 포켓몬의 이름
    let sprites: PokemonImageData // 포켓몬의 이미지 데이터를 담고있는 구조체
    
    // 'PokemonImageData' 구조체는 포켓몬의 이미지 관련 데이터를 표현
    struct PokemonImageData: Decodable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

// 'PokemonAPIManager' 클래스는 API 호출을 관리하는 역활
class PokemonAPIManager {
    // 싱글톤 패턴 구현: 전역에서 `shared`를 통해 동일한 인스턴스를 사용
    static let shared = PokemonAPIManager()
    
    // 외부에서 인스턴스를 생성하지 못하도록 `private` 생성자를 선언
    private init() {}
    
    func pokemonData(completion: @escaping (Pokemon?) -> Void) {
        
        // 1부터 1000까지의 랜던 ID 생성
        let randomID = Int.random(in: 1...1000)
        
        // 랜덤 ID를 포함한 API URL 생성
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        
        // 문자열을 URL 객체로 변환
        guard let url = URL(string: urlString) else {
            // URL이 유효하지 않으면 nil을 반환
            completion(nil)
            return
        }
        
        // URL 요청을 수행하기 위해 `URLSession`의 `dataTask`를 생성
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 요청 중 에러가 발생한 경우 처리
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            // 데이터가 없을 경우 처리
            guard let data = data else {
                completion(nil)
                return
            }
            
            // JSON 데이터를 `Pokemon` 구조체로 디코딩
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                // 디코딩된 포켓몬 데이터를 completion 클로저로 반환
                completion(pokemon)
            } catch {
                // 디코딩 중 에러 발생 시 처리
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}

