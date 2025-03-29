//
//  Entity.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 14/02/25.
//

class Entity {
    var name: String
    init(name: String) { self.name = name }
}

class EntityManager {
    private var entities: [Entity?] = []
    private var freeSlots: [Int] = []
    private var generations: [Int] = []
    
    struct Handle {
        let index: Int
        let generation: Int
    }
    
    func createEntity(name: String) -> Handle {
        let entity = Entity(name: name)
        
        if let index = freeSlots.popLast() {
            entities[index] = entity
            generations[index] += 1
            return Handle(index: index, generation: generations[index])
        } else {
            entities.append(entity)
            generations.append(1)
            return Handle(index: entities.count - 1, generation: 1)
        }
    }
    
    func getEntity(handle: Handle) -> Entity? {
        guard handle.index < entities.count,
              let entity = entities[handle.index],
              generations[handle.index] == handle.generation else {
            return nil // Handle is invalid
        }
        return entity
    }
    
    func destroyEntity(handle: Handle) {
        guard handle.index < entities.count,
              entities[handle.index] != nil,
              generations[handle.index] == handle.generation else {
            return // Invalid handle
        }
        
        entities[handle.index] = nil
        freeSlots.append(handle.index)
        generations[handle.index] += 1
    }
}
