//
//  UrlPokemon+CoreDataProperties.swift
//  Pokemon
//
//  Created by НИКИТА ПЕСНЯК on 13.09.24.
//
//

import Foundation
import CoreData


extension UrlPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UrlPokemon> {
        return NSFetchRequest<UrlPokemon>(entityName: "UrlPokemon")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var descriptionPokemon: DescriptionPokemon?

}

extension UrlPokemon : Identifiable {

}
