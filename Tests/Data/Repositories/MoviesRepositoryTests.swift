//
//  MoviesRepositoryTests.swift
//  movies_uikitTests
//
//  Created by Ademola Fadumo on 06/09/2023.
//

import XCTest
@testable import movies_uikit

class MockMovie: Movie {}

class MockTVShow: TVShow {}

class MockLocalStorage: LocalStorage {
    func create(object: AnyObject) {}

    func update(object: AnyObject) {}

    func read<ObjectType>(
        object: ObjectType.Type,
        completion: @escaping (AnyObject?, Error?) -> Void
    ) where ObjectType: AnyObject {}

    func readAll<ObjectType>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?,
        completion: @escaping ([ObjectType], Error?) -> Void
    ) where ObjectType : AnyObject {}

    func updateProperty(
        callback: @escaping () -> Void
    ) {}
}

class MockHTTPClient: HTTPClient {
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: [String: String]?,
        response: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>) -> Void
    ) -> URLSessionTask? {
        return nil
    }

    func post<ResponseType: Decodable>(
        url: URL?,
        parameters: Encodable,
        response: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>
    ) -> Void) -> URLSessionTask? {
        return nil
    }
}

class MockMoviesAPI: MoviesAPI {
    override func getMovies(categoryType: String, completion: @escaping (Result<[movies_uikit.Movie], Error>) -> Void) {
        if categoryType == "movie" {
            let mockMovie = MockMovie()
            completion(.success([mockMovie]))
        } else {
            completion(.success([]))
        }
    }

    override
    func getTVShows(categoryType: String, completion: @escaping (Result<[movies_uikit.TVShow], Error>) -> Void) {
        if categoryType == "tv" {
            let mockTVShow = MockTVShow()
            completion(.success([mockTVShow]))
        } else {
            completion(.success([]))
        }
    }
}

final class MoviesRepositoryTests: XCTestCase {

    var mockLocalStorage: MockLocalStorage!
    var mockHTTPClient: MockHTTPClient!
    var mockMoviesAPI: MockMoviesAPI!
    var sut: MoviesRepositoryImpl!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockLocalStorage = MockLocalStorage()
        mockHTTPClient = MockHTTPClient()
        mockMoviesAPI = MockMoviesAPI(httpClient: mockHTTPClient, localStorage: mockLocalStorage)
        sut = MoviesRepositoryImpl(moviesAPI: mockMoviesAPI)
    }

    override func tearDownWithError() throws {
        mockLocalStorage = nil
        mockHTTPClient = nil
        mockMoviesAPI = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetMoviesReturnsAListOfMovies() {
        let expectation = XCTestExpectation(description: "Returns a list of movies")

        sut.getMovies(categoryType: "movie") { movies in
            if !movies.isEmpty {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetTVShowsReturnsAListOfTVShows() {
        let expectation = XCTestExpectation(description: "Returns a list of tv shows")

        sut.getTVShows(categoryType: "tv") { tvShows in
            if !tvShows.isEmpty {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }
}
