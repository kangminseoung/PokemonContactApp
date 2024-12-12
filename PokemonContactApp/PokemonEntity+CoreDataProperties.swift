//
//  PokemonEntity+CoreDataProperties.swift
//  PokemonContactApp
//
//  Created by 강민성 on 12/11/24.
//
//

import Foundation
import CoreData


extension PokemonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonEntity> {
        return NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension PokemonEntity : Identifiable {

}
