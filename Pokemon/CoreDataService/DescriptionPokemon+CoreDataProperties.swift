//
//  DescriptionPokemon+CoreDataProperties.swift
//  Pokemon
//
//  Created by НИКИТА ПЕСНЯК on 13.09.24.
//
//

import Foundation
import CoreData


extension DescriptionPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DescriptionPokemon> {
        return NSFetchRequest<DescriptionPokemon>(entityName: "DescriptionPokemon")
    }

    @NSManaged public var name: String?
    @NSManaged public var types: String?
    @NSManaged public var weight: Double
    @NSManaged public var height: Double
    @NSManaged public var url_photo: String?
    @NSManaged public var urlPokemon: UrlPokemon?
    @NSManaged public var imagePokemon: ImagePokemon?

}

extension DescriptionPokemon : Identifiable {

}
