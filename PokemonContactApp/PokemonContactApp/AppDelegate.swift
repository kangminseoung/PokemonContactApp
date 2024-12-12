//
//  AppDelegate.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/9/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonContactApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData 초기화 실패: \(error.localizedDescription)")
            } else {
                print("CoreData 초기화 성공: \(description)")
                print("컨텍스트: \(container.viewContext)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 메인 윈도우 설정
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // fatalError 대신 사용자 친화적인 에러 처리 방식 사용
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                #if DEBUG
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif
            }
        }
    }

    // 디버깅용 Core Data 상태 확인 메서드
    private func testCoreDataSetup() {
        let testContext = persistentContainer.viewContext
        do {
            // PokemonEntity 엔티티 존재 여부 확인
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PokemonEntity")
            let result = try testContext.fetch(fetchRequest)
            print("PokemonEntity 데이터 로드 성공, 개수: \(result.count)")
        } catch {
            print("PokemonEntity 데이터 로드 실패: \(error)")
        }

        // 엔티티가 없는 경우 경고 로그 출력
        guard let model = persistentContainer.managedObjectModel.entitiesByName["PokemonEntity"] else {
            print("PokemonEntity가 CoreData 모델에 정의되어 있지 않습니다.")
            return
        }

        print("PokemonEntity 모델 확인 성공: \(model)")
    }
}
