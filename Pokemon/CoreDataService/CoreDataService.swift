import Foundation
import CoreData

class CoreDataService{
    static var shared = CoreDataService()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func saveUrlPokemon(with urls: [UrlPokemonStruct]) {
        context.perform { [weak self] in
            guard let self = self else { return }
            for url in urls {
                let newUrl = UrlPokemon(context: self.context)
                newUrl.name = url.name
                newUrl.url = url.url
            }
            self.saveContext()
        }
    }
    func saveDecriptionPokemon(with decriptions: [DecriptionPokemonStruct]) {
        context.perform { [weak self] in
            guard let self = self else { return }
            for decription in decriptions {
                let newDecription = DescriptionPokemon(context: self.context)
                newDecription.name = decription.name
                newDecription.url_photo = decription.url_photo
                newDecription.types = decription.types
                newDecription.weight = decription.weight
                newDecription.height = decription.height
            }
            self.saveContext()
        }
    }
    
    func saveImagePokemon(with images: [ImagePokemonStruct]) {
        context.perform { [weak self] in
            guard let self = self else { return }
            for image in images {
                let newImage = ImagePokemon(context: self.context)
                newImage.image = image.image
            }
            self.saveContext()
        }
    }

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
