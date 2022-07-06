//
//  DefaultAlbumRepository.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import Foundation

final class DefaultAlbumRepository {
    private let cache: AlbumsStorage

    init(cache: AlbumsStorage) {
        self.cache = cache
    }
}

extension DefaultAlbumRepository: AlbumRepository {
    func fetchAlbumList(cached: @escaping ([Album]) -> Void, completion: @escaping (Result<[Album], Error>) -> Void) {
        cache.getAllAlbums { result in
            switch result {
            case .success(let albums):
                cached(albums)
            case .failure:
                cached([])
            }
        }

        APIEndpoint.getAlbums(parameters: AlbumsParamters()) { [weak self] result in
            switch result {
            case .success(let albumResponseDTO):
                let albums = albumResponseDTO.feed.results.map { $0.toDomain() }
                let realmStorageAlbums = albumResponseDTO.feed.results.map { $0.toDomain() }

                self?.cache.save(albums: realmStorageAlbums)
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
