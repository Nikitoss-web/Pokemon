struct DecriptionPokemonResponse: Decodable{
    var height: Double
    var id: Int
    var name: String
    var weight: Double
    var types: [TypeSlot]
    
}

struct PokemonType: Decodable {
    var name: String
    var url: String
}

struct TypeSlot: Decodable {
    var slot: Int
    var type: PokemonType
}

struct newStruct{
    var height: Double
    var id: Int
    var name: String
    var weight: Double
    var types: String?
}
