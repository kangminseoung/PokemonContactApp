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

    // Read
    func fetchContacts() -> [PokemonEntity] {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch Error: \(error)")
            return []
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
