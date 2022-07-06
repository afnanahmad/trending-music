//
//  AlbumRepository.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import Foundation

protocol AlbumRepository {
    func fetchAlbumList(cached: @escaping ([Album]) -> Void,
                        completion: @escaping (Result<[Album], Error>) -> Void) -> Void
}
