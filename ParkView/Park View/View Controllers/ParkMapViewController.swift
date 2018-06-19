

import UIKit
import MapKit

class ParkMapViewController: UIViewController {
  
 // var selectedOptions : [MapOptionsType] = []
  let parkMapViewModel = ParkMapViewModel()
  let locationManager = CLLocationManager()
  @IBOutlet weak var mapView: MKMapView!
   
  var parkModels = ParkListReader().parseParks(fileName:"MagicMountain")
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.parkMapViewModel.loadParkModels()
    /*set the mapview region on launch of the app*/
    self.parkMapViewModel.setMapViewRegion(mapView:self.mapView)
    
  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.parkMapViewModel.checkLocationAuthorizationStatus(locationManager:locationManager,mapView:self.mapView)
    }
    
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    (segue.destination as? MapOptionsViewController)?.selectedOptions = self.parkMapViewModel.selectedOptions
  }
  
  @IBAction func closeOptions(_ exitSegue: UIStoryboardSegue) {
    guard let vc = exitSegue.source as? MapOptionsViewController else { return }
    self.parkMapViewModel.selectedOptions = vc.selectedOptions
    self.parkMapViewModel.loadSelectedOptions(mapView: self.mapView)
  }
    
  
  @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
    // TODO
    self.mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    
  }
}

extension ParkMapViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is ParkMapOverlay {
            return ParkMapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "overlay_park"))
            
        }else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.green
            return lineView
        }else if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.magenta
            return polygonView
        }
        
        return MKOverlayRenderer()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }
    
}

