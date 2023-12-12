//
//  MoviesResponse.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RealmSwift

// MARK: - MoviesResponse
struct MoviesResponse: Decodable {
    let page: Int
    let results: [MovieDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
class MovieDTO: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var adult: Bool
    @Persisted var backdropPath: String
    @Persisted var genreIDS: List<Int>
    @Persisted var movieId: Int
    @Persisted var originalTitle: String
    @Persisted var overview: String
    @Persisted var popularity: Double
    @Persisted var posterPath: String
    @Persisted var releaseDate: String
    @Persisted var title: String
    @Persisted var video: Bool
    @Persisted var voteAverage: Double
    @Persisted var voteCount: Int
    @Persisted var createdAt: Date = Date()
    @Persisted var bookmarked: Bool

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case movieId = "id"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    convenience init(
        backdropPath: String,
        movieId: Int,
        originalTitle: String,
        overview: String,
        posterPath: String,
        releaseDate: String,
        voteAverage: Double,
        bookmarked: Bool
    ) {
        self.init()
        self.backdropPath = backdropPath
        self.movieId = movieId
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.bookmarked = bookmarked
    }
}
