//
//  Show.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/12/2023.
//

import Foundation

enum ShowType {
    case movie
    case tv
}

struct Show {
    let id: Int
    let type: ShowType
    let title: String
    let releaseDate: String?
    let overview: String
    let rating: Double
    let posterPath: String
    let backdropPath: String?
    let bookmarked: Bool

    func toMovieDTO() -> MovieDTO {
        return MovieDTO(
            backdropPath: backdropPath ?? "",
            movieId: id,
            originalTitle: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate ?? "",
            voteAverage: rating,
            bookmarked: bookmarked
        )
    }

    func toTVShowDTO() -> TVShowDTO {
        return TVShowDTO(
            backdropPath: backdropPath ?? "",
            firstAirDate: releaseDate ?? "",
            tvShowId: id,
            originalName: title,
            overview: overview,
            posterPath: posterPath,
            voteAverage: rating,
            bookmarked: bookmarked
        )
    }
}

extension TVShowDTO {
    func toShow() -> Show {
        return Show(
            id: self.tvShowId,
            type: .tv,
            title: self.originalName,
            releaseDate: self.firstAirDate,
            overview: self.overview,
            rating: self.voteAverage,
            posterPath: self.posterPath,
            backdropPath: self.backdropPath,
            bookmarked: self.bookmarked
        )
    }
}

extension MovieDTO {
    func toShow() -> Show {
        return Show(
            id: self.movieId,
            type: .movie,
            title: self.originalTitle,
            releaseDate: self.releaseDate,
            overview: self.overview,
            rating: self.voteAverage,
            posterPath: self.posterPath,
            backdropPath: self.backdropPath,
            bookmarked: self.bookmarked
        )
    }
}
