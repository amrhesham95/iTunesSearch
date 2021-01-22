// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resultWrapper = try? newJSONDecoder().decode(ResultWrapper.self, from: jsonData)

import Foundation

// MARK: - ResultWrapper
struct ResultWrapper: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable {
    let artistName: String
    let trackName: String
    private let artworkUrl30: String
    var imageIcon: String {
        return artworkUrl30
    }
}
