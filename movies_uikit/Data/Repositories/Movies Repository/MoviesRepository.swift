//
//  MoviesRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

protocol MoviesRepository {
    func getMovies(
        categoryType: String,
        completion: @escaping ([Show]) -> Void
    )

    func getTVShows(
        categoryType: String,
        completion: @escaping ([Show]) -> Void
    )

    func getRecommendedShowsForMovie(
        id: String,
        completion: @escaping ([Show]) -> Void
    )

    func getRecommendedShowsForTVShow(
        id: String,
        completion: @escaping ([Show]) -> Void
    )

    func getMovieSearchResults(
        from query: String,
        completion: @escaping ([Show]) -> Void
    )

    func getTVShowsSearchResults(
        from query: String,
        completion: @escaping ([Show]) -> Void
    )
}
