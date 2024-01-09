//
//  MoviesRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RxSwift

protocol MoviesRepository {
    func getMovies(categoryType: String) -> Observable<Result<[Show], APIError>>

    func getTVShows(categoryType: String) -> Observable<Result<[Show], APIError>>

    func getRecommendedShowsForMovie(id: String) -> Observable<Result<[Show], APIError>>

    func getRecommendedShowsForTVShow(id: String) -> Observable<Result<[Show], APIError>>

    func getMovieSearchResults(from query: String) -> Observable<Result<[Show], APIError>>

    func getTVShowsSearchResults(from query: String) -> Observable<Result<[Show], APIError>>
}
