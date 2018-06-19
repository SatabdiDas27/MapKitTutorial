//
//  MapOptionsType.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

enum MapOptionsType: Int {
    case mapBoundary = 0
    case mapOverlay
    case mapPins
    case mapCharacterLocation
    case mapRoute
    
    func displayName() -> String {
        switch (self) {
        case .mapBoundary:
            return "Park Boundary"
        case .mapOverlay:
            return "Map Overlay"
        case .mapPins:
            return "Attraction Pins"
        case .mapCharacterLocation:
            return "Character Location"
        case .mapRoute:
            return "Route"
        }
    }
}
