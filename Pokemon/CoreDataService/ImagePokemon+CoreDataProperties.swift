//
//  ImagePokemon+CoreDataProperties.swift
//  Pokemon
//
//  Created by НИКИТА ПЕСНЯК on 13.09.24.
//
//

import Foundation
import CoreData


extension ImagePokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImagePokemon> {
        return NSFetchRequest<ImagePokemon>(entityName: "ImagePokemon")
    }

    @NSManaged public var image: Date?
    @NSManaged public var descriptionPokemon: DescriptionPokemon?

}

extension ImagePokemon : Identifiable {

}
