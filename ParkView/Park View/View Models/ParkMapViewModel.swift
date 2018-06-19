//
//  ParkMapViewModel.swift
//  Park View
//
//  Created by Satabdi Das on 18/06/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

class ParkMapViewModel: NSObject {

    var selectedOptions : [MapOptionsType] = []
    var parkModels:ParkModel!
    var attractionAnnotations:[AttractionAnnotation]!
    var parkRoutePoints:[String]!
    func loadParkModels() {
        
        parkModels = ParkListReader().parseParks(fileName:"MagicMountain")
        attractionAnnotations = ParkListReader().parseAnnotations(fileName:"MagicMountainAttractions")
        parkRoutePoints = ParkListReader().parseRouteCoordinates(fileName:"EntranceToGoliathRoute") as! [String]
    }
    func setMapViewRegion(mapView:MKMapView) {
        
        let latDelta = (self.parkModels?.overlayTopLeftCoordinate.latitude)! -
            (parkModels?.overlayBottomRightCoordinate.latitude)!
        
        // Think of a span as a tv size, measure from one corner to another
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        let region = MKCoordinateRegionMake((parkModels?.midCoordinate)!, span)
        
        mapView.region = region
    }
    
    func checkLocationAuthorizationStatus(locationManager:CLLocationManager,mapView:MKMapView) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addOverlay(mapView:MKMapView) {
        
        let overlay = ParkMapOverlay(park: parkModels!)
        mapView.add(overlay)
    }
    
    func addAttractionPins(mapView:MKMapView) {
        
         mapView.addAnnotations(attractionAnnotations)
    }
    
    func addRoute(mapView:MKMapView) {
        
        let cgPoints = parkRoutePoints.map { CGPointFromString($0) }
        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
        
        mapView.add(myPolyline)
    }
    
    func addBoundary(mapView:MKMapView) {
        
        mapView.add(MKPolygon(coordinates: parkModels.boundary, count: parkModels.boundary.count))
    }
    
    func loadSelectedOptions(mapView:MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        for option in self.selectedOptions {
            switch (option) {
            case .mapOverlay:
                addOverlay(mapView:mapView)
            case .mapPins:
                addAttractionPins(mapView:mapView)
            case .mapRoute:
                addRoute(mapView: mapView)
            case .mapBoundary:
                addBoundary(mapView: mapView)
            default:
                break;
            }
        }
    }
    
}
