//
//  AlbumResponseDTO+Mapping.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import Foundation
import RealmSwift

// MARK: - AlbumResponseDTO

struct AlbumResponseDTO: Codable {
    let feed: FeedDTO
}

// MARK: - Feed

struct FeedDTO: Codable {
    let title: String
    let id: String
    let author: AuthorDTO
    let links: [LinkDTO]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [AlbumDTO]
}

// MARK: - Author

struct AuthorDTO: Codable {
    let name: String
    let url: String
}

// MARK: - Link

struct LinkDTO: Codable {
    let linkSelf: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - Result

struct AlbumDTO: Codable {
    let artistName, id, name, releaseDate: String
    let kind: KindDTO
    let artistID: String?
    let artistURL: String?
    let contentAdvisoryRating: ContentAdvisoryRatingDTO?
    let artworkUrl100: String
    let genres: [GenreDTO]
    let url: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case contentAdvisoryRating, artworkUrl100, genres, url
    }
}

enum ContentAdvisoryRatingDTO: String, Codable {
    case explict = "Explict"
}

// MARK: - Genre

struct GenreDTO: Codable {
    let genreID, name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum KindDTO: String, Codable {
    case albums
}

// MARK: - Mappings to Domain

extension AlbumDTO {
    func toDomain() -> Album {
        let album = Album()
        album.artistName = artistName
        album.id = id
        album.name = name
        album.artistID = artistID
        album.artworkUrl100 = artworkUrl100
        album.releaseDate = releaseDate
        album.artistURL = artistURL
        album.contentAdvisoryRating = contentAdvisoryRating?.toDomain()
        album.url = url
        album.kind = kind.toDomain()

        let mappedGernes = genres.map { $0.toDomain() }
        let genresList = List<Genre>()
        genresList.append(objectsIn: mappedGernes)

        album.genres = genresList

        return album
    }
}

extension ContentAdvisoryRatingDTO {
    func toDomain() -> ContentAdvisoryRating? {
        return ContentAdvisoryRating(rawValue: rawValue)
    }
}

extension GenreDTO {
    func toDomain() -> Genre {
        let genre = Genre()
        genre.genreID = genreID
        genre.name = name
        genre.url = url

        return genre
    }
}

extension KindDTO {
    func toDomain() -> Kind? {
        return Kind(rawValue: rawValue)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func albumResponseDTOTask(with url: URL, completionHandler: @escaping (AlbumResponseDTO?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return codableTask(with: url, completionHandler: completionHandler)
    }
}
