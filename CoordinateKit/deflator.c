//
//  CoordinateDeflator.c
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

#import "deflator.h"

#define DEFLATED_COORDINATE_LENGTH  8
#define ACCURACY_COEFFICIENT        10000000.0

uint64_t _coordinateKitDeflateCoordinate(double latitude, double longitude) {
    
    // TODO: Validate coordinates
    
    int32_t dlat = (int32_t)latitude +  90;  // Convert from  -90 : 90  to 0 : 180
    int32_t dlon = (int32_t)longitude + 180; // Convert from -180 : 180 to 0 : 360
    
    uint16_t gridPosition = (dlat * 360) + dlon; // Value between 0 : 64,800
    
    uint32_t deltaLat = (fabs(latitude)  - abs((int32_t)latitude))  * ACCURACY_COEFFICIENT;
    uint32_t deltaLon = (fabs(longitude) - abs((int32_t)longitude)) * ACCURACY_COEFFICIENT;
    
    uint64_t data = 0;
    
    memcpy((uint8_t *)&data + 0, (uint8_t *)&gridPosition, 2);
    memcpy((uint8_t *)&data + 2, (uint8_t *)&deltaLat,  3);
    memcpy((uint8_t *)&data + 5, (uint8_t *)&deltaLon,  3);
    
    return data;
}

void _coordinateKitInflateCoordinate(uint64_t compressedCoordinate, double *latitude, double *longitude) {
    
    uint16_t gridPosition = 0;
    uint32_t remLat       = 0;
    uint32_t remLon       = 0;
    
    memcpy(&gridPosition, (uint8_t *)&compressedCoordinate + 0, 2);
    memcpy(&remLat,       (uint8_t *)&compressedCoordinate + 2, 3);
    memcpy(&remLon,       (uint8_t *)&compressedCoordinate + 5, 3);
    
    double deltaLat = remLat / ACCURACY_COEFFICIENT;
    double deltaLon = remLon / ACCURACY_COEFFICIENT;
    
    double dlat = gridPosition / 360 -  90;
    double dlon = gridPosition % 360 - 180;
    
    double lat = dlat > 0.0 ? dlat + deltaLat : dlat - deltaLat;
    double lon = dlon > 0.0 ? dlon + deltaLon : dlon - deltaLon;
    
    *latitude = lat;
    *longitude = lon;
}
