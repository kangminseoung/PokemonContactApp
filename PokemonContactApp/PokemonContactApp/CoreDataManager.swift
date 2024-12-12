//
//  CoreDataManager.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/11/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    // Persistent Container 설정
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonContactApp") // 모델 이름
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData 저장소 로드 실패: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func createContact(name: String, phoneNumber: String, imageURL: String?) {
        // 이미지 URL이 없는 경우 저장하지 않음
        guard let imageURL = imageURL, !imageURL.isEmpty else {
            print("Skipping save because imageURL is nil or empty.")
            return
        }
        
        // 중복 데이터 확인
        guard !contactExists(name: name, phoneNumber: phoneNumber) else {
            print("Contact already exists. Skipping save.")
            return
        }

        let entityDescription = NSEntityDescription.entity(forEntityName: "PokemonEntity", in: context)
        print("Entity Description: \(String(describing: entityDescription))")
        guard let entityDescription = entityDescription else {
            fatalError("PokemonEntity의 NSEntityDescription을 찾을 수 없습니다.")
        }

        let contact = PokemonEntity(entity: entityDescription, insertInto: context)
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.imageURL = imageURL
        saveContext()
    }

    func fetchContacts() -> [(name: String, phoneNumber: String, imageURL: String?)] {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            return results.map { ($0.name ?? "", $0.phoneNumber ?? "", $0.imageURL) }
        } catch {
            print("Fetch Error: \(error)")
            return []
        }
    }

    // 중복 확인 메서드 추가
    private func contactExists(name: String, phoneNumber: String) -> Bool {
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND phoneNumber == %@", name, phoneNumber)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking contact existence: \(error)")
            return false
        }
    }

    // Update
    func updateContact(contact: PokemonEntity, name: String, phoneNumber: String, imageURL: String?) {
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.imageURL = imageURL
        saveContext()
    }

    // Delete
    func deleteContact(contact: PokemonEntity) {
        context.delete(contact)
        saveContext()
    }

    // Save
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("CoreData 저장 실패: \(error)")
            }
        }
    }
}
