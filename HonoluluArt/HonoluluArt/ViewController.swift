

import UIKit
import MapKit

class ViewController: UIViewController {
  
 @IBOutlet weak var mapView:MKMapView!
 let regionRadius:CLLocationDistance = 1000
 let mapViewModel = ArtWorkViewModel()
 let locationManager = CLLocationManager()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let name = "MapViewScreen"
    let tracker = GAI.sharedInstance().defaultTracker
    tracker?.set(kGAIScreenName, value: name)
   // GAI.sharedInstance().trac
    
    let builder = GAIDictionaryBuilder.createScreenView()
    tracker?.send(builder?.build()! as! [NSObject : AnyObject])
    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    //let initialLocation = CLLocation(latitude: 21.290824, longitude: -157.85131)
    centerMapOnLocation(location:initialLocation)
  //  let artworkSculpt = Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
   //  let artworkMural = Artwork(title: "The Makahiki Festival – The Makai Mural", locationName: "Lester McCoy Pavilion", discipline: "Mural", coordinate: CLLocationCoordinate2D(latitude: 21.290824, longitude: -157.85131))
    
    //self.mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
     self.mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    self.mapViewModel.loadInitialData {
        self.mapView.addAnnotations(self.mapViewModel.artworks)
    }
    
    
  }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
   
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
   

    func centerMapOnLocation(location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension ViewController:MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? Artwork else { return nil }
//        // 3
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        // 4
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        
        
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

