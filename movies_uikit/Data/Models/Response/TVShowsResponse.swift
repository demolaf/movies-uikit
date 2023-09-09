//
//  TVShowsResponse.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation
import RealmSwift

// MARK: - TVShowsResponse
struct TVShowsResponse: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TVShow
class TVShow: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var backdropPath: String?
    @Persisted var firstAirDate: String?
    @Persisted var genreIDS: List<Int>
    @Persisted var tvShowId: Int
    @Persisted var name: String
    @Persisted var originCountry: List<String>
    @Persisted var originalLanguage: String
    @Persisted var originalName: String
    @Persisted var overview: String
    @Persisted var popularity: Double
    @Persisted var posterPath: String
    @Persisted var voteAverage: Double
    @Persisted var voteCount: Int
    @Persisted var createdAt: Date = Date()

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case tvShowId = "id"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
