//
//  SearchResult.swift
//  iTunes_Search_App
//
//  Created by Rakesh Kumar on 4/15/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int?
    let results: [ItunesAPIResult]?
}

// MARK: - Result
struct ItunesAPIResult: Codable {
    let wrapperType: String?
    let kind: Kind
    let artistID, collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistID: Int?
    let collectionArtistViewURL: String?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let contentAdvisoryRating, longDescription: String?
    let hasITunesExtras: Bool?
    let shortDescription, collectionArtistName: String?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case contentAdvisoryRating, longDescription, hasITunesExtras, shortDescription, collectionArtistName
    }
}

enum Kind: String, Codable {
    case song = "song"
    case book = "book"
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdfPodcast = "pdf podcast"
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case tvEpisode = "tv-episode"
    case artist = "artist"
    
}
