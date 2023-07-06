////
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import Foundation

struct AboutReleaseDescription: Decodable {
    let version: String
    let date: Date
    let news: String
}

class AboutReleaseDescriptionsLoader {

    // =================
    // MARK: Initializer
    // =================

    init() { }

    enum Error: Swift.Error {
        case resourceNotFound
        case noJsonData
    }

    // ====================
    // MARK: Private Helper
    // ====================

    func load(from applicationNewsPath: String) throws -> [AboutReleaseDescription] {

        guard FileManager().fileExists(atPath: applicationNewsPath) else {
            throw Error.resourceNotFound
        }
        
        guard let jsonData = try String(contentsOfFile: applicationNewsPath).data(using: .utf8) else {
            throw Error.noJsonData
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode([AboutReleaseDescription].self, from: jsonData)
    }
}

extension AboutReleaseDescription {
    static func load() throws -> [AboutReleaseDescription] {
        return try AboutReleaseDescriptionsLoader().load(from: "AppNews")
    }
}
