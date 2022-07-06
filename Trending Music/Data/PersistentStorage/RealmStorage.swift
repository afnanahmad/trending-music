//
//  RealmStorage.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import Foundation
import RealmSwift

final class RealmStorage {}

extension RealmStorage: AlbumsStorage {
    func getAllAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        let realm = try? Realm()
        if let albumsList = realm?.objects(Album.self) {
            let albums = Array(albumsList)
            completion(.success(albums))
        } else {
            completion(.success([]))
        }
    }

    func save(albums: [Album]) {
        do {
            let realm = try? Realm()
            let albumsList = realm?.objects(Album.self)
            try realm?.write {
                if let albumsList = albumsList {
                    realm?.delete(albumsList)
                }
                realm?.add(albums)
            }

        } catch {}
    }
}
