//
//  ParkMapOverlay.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit
//mkoverlay tells mapkit where the overlays will be drawn
class ParkMapOverlay: NSObject,MKOverlay {

    var coordinate:CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(park:ParkModel) {
        
        boundingMapRect = park.overlayBoundingMapRect
        coordinate = park.midCoordinate
    }
}
