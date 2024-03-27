import UIKit

class Source {
    static let shared = Source()
    private init() {}
    
    lazy var names: [String] = {
        return ["Alex", "Bob", "Anton", "Anna", "Egor"]
    }()
    
    lazy var images: [String] = {
        return ["person1", "person2", "person3", "person4"]
    }()
    
    func createPeopleArray(count: Int) -> [Person] {
        var people = [Person]()
        for _ in 0..<count {
            let person = Person(name: names.randomElement() ?? "Unknown", image: images.randomElement() ?? "defaultImage")
            people.append(person)
        }
        return people
    }
}
