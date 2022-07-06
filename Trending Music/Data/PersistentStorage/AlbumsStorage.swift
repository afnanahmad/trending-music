//
//  AlbumsStorage.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import Foundation

protocol AlbumsStorage {
    func getAllAlbums(completion: @escaping (Result<[Album], Error>) -> Void)
    func save(albums: [Album])
}
