//
//  APIEndpoint.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import Foundation

struct AlbumsParamters {
    let mediaType = "music"
    let storeFront = "us"
    let feed = "most-played"
    let resultLimit = "100"
}

enum APIEndpoint {
    static let appConfiguration = AppConfiguration()

    static func getAlbums(parameters: AlbumsParamters, completion: @escaping (Result<AlbumResponseDTO, Error>) -> Void) {
        let baseURL = appConfiguration.apiBaseURL
        let endpoint = "albums.json"

        let components = [parameters.storeFront, parameters.mediaType, parameters.feed, parameters.resultLimit, endpoint]

        var url = URL(string: baseURL)

        for component in components {
            url?.appendPathComponent(component)
        }

        if let url = url {
            let task = URLSession.shared.albumResponseDTOTask(with: url) { albumResponseDTO, _, error in

                if let albumResponseDTO = albumResponseDTO {
                    completion(.success(albumResponseDTO))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
