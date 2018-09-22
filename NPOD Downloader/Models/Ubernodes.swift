//
//  Ubernodes.swift
//  NPOD Downloader
//
//  Created by Giulio Lombardo on 22/09/18.
//  Copyright © 2018 Giulio Lombardo. All rights reserved.
//

import Foundation

struct Ubernodes: Decodable {
    struct Ubernode: Decodable {
		private enum CodingKeys: String, CodingKey {
			case type
			case promoDateTime
			case id = "nid"
		}

        let type: String
        private let promoDateTime: String // cambiare in Date
        let id: String

		var date: Date? {
			let dateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
			dateFormatter.formatOptions = .withInternetDateTime

			return dateFormatter.date(from: promoDateTime)
		}
    }

    let ubernodes: [Ubernode]
}
