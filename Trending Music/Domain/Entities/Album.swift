//
//  Album.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import Foundation
import RealmSwift

// MARK: - Result

class Album: Object {
    @Persisted var artistName: String?
    @Persisted var id: String = ""
    @Persisted var name: String?
    @Persisted var releaseDate: String?
    @Persisted var kind: Kind?
    @Persisted var artistID: String?
    @Persisted var artistURL: String?
    @Persisted var contentAdvisoryRating: ContentAdvisoryRating?
    @Persisted var artworkUrl100: String?
    @Persisted var genres: List<Genre>
    @Persisted var url: String?
}

enum ContentAdvisoryRating: String, PersistableEnum {
    case explict = "Explict"
}

// MARK: - Genre

class Genre: Object {
    @Persisted var genreID: String?
    @Persisted var name: String?
    @Persisted var url: String?
}

enum Kind: String, PersistableEnum {
    case albums
}
