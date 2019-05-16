//
//  CoordinateDeflator+Data.swift
//  CoordinateKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Dima Bart
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#if canImport(CoreLocation)

import CoreLocation

extension Coordinate {
    
    public static func deflate(coordinatesToData coordinates: [CLLocationCoordinate2D]) -> Data {
        let values: [UInt64] = self.deflate(coordinates: coordinates)
        var buffer: Data     = Data()
        
        values.withUnsafeBytes { bytes in
            for var byte in bytes {
                buffer.append(&byte, count: 1)
            }
        }
        
        return buffer
    }
    
    public static func inflate(data: Data) -> [CLLocationCoordinate2D] {
        guard data.count >= 8 else {
            return []
        }
        
        
        return data.withUnsafeBytes { buffer in
            buffer.bindMemory(to: UInt64.self).map {
                Coordinate.inflate(coordinate: $0)
            }
        }
    }
}

// MARK: - Base64 -

extension Coordinate {
    
    public static func deflate(coordinatesToBase64 coordinates: [CLLocationCoordinate2D]) -> String {
        return self.deflate(coordinatesToData: coordinates).base64EncodedString()
    }
    
    public static func inflate(base64: String) -> [CLLocationCoordinate2D] {
        guard let data = Data(base64Encoded: base64) else {
            return []
        }
        
        return self.inflate(data: data)
    }
}

#endif
