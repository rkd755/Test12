//
//  TotalMapViewController.swift
//  FreeFood
//
// DetailsInfo item name
// idx : 일련번호
// name : 시설명        : title
// loc :  급식장소
// target : 급식대상     : 2 cell
// mealDay : 급식일     : 1 cell
// time : 급식시간
// startDay : 운영시작일
// endDay : 운영종료일
// manageNm : 운영기관명  : 3 cell
// phone : 연락처        : 4 cell
// addr : 지번주소
// lng : 경도
// lat : 위도
// gugun : 구군

// DetailsInfo item name
//결과코드          resultCode
//결과메세지         resultMsg
//쿼리 페이지 시작점	pageIndex
//페이지 크기        pageSize
//시작 페이지        startPage
//전체 결과 수       totalCount
//고유코드          tourId
//명칭            tourNm
//메뉴명           tourMenuNm
//지역코드          tourZoneCd
//지역명           tourZoneNm
//주소             tourAddr
//전화번호          tourTel
//경도            tourXpos
//위도            tourYpos
//메인이미지경로      tourMainImg
//  Created by 김종현 on 2017. 11. 12..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TotalMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var segementItem: UISegmentedControl!
    @IBAction func segementBtn(_ sender: UISegmentedControl) {
        zoomToRegion()
        print(locationManager.location!.coordinate.latitude)
        switch segementItem.selectedSegmentIndex {
        case 0:
            myMapView.showAnnotations(annos, animated: true)
        default:
            break
        }
        
    }
    var annos = [MKPointAnnotation]()
    @IBOutlet weak var myMapView: MKMapView!
    var locationManager: CLLocationManager!
    var tItems:[[String:String]] = []

    var longa : Double = 0.0
    var lati : Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // 현재 위치 트랙킹
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        // 지도에 현재 위치 마크를 보여줌
        myMapView.showsUserLocation = true
        
        self.title = "전라도 섬 위치"
        zoomToRegion()
        
        //print("tItems = \(tItems)")
        // lat, lng
        
        
        for item in tItems {
            let anno = MKPointAnnotation()
            
            let lat = item["tourYpos"]
            let long = item["tourXpos"]
            
            if lat != nil {
                let fLat = (lat! as NSString).doubleValue
                let fLong = (long! as NSString).doubleValue
                
                anno.coordinate.latitude = fLat
                anno.coordinate.longitude = fLong
                anno.title = item["tourNm"]
                anno.subtitle = item["tourAddr"]
                annos.append(anno)
            }
            
            
        }
        //myMapView.showAnnotations(annos, animated: true)
        myMapView.addAnnotations(annos)
        myMapView.selectAnnotation(annos[0], animated: true)
        
    }

    func zoomToRegion() {
        // 35.162685, 129.064238
        var center = CLLocationCoordinate2DMake(34.6001389, 127.6477917)
//        longa = locationManager.location!.coordinate.longitude
//        lati = locationManager.location!.coordinate.latitude
        var span = MKCoordinateSpanMake(0.35, 0.44)
        
        switch segementItem.selectedSegmentIndex {
        case 1:
            span = MKCoordinateSpanMake(0.25, 0.2)
        case 2:
            span = MKCoordinateSpanMake(0.63, 0.5)
        case 3:
            span = MKCoordinateSpanMake(1, 1.13)
        default:
            span = MKCoordinateSpanMake(0.35, 0.44)
            
        }
        
        var region = MKCoordinateRegionMake(center, span)
       
        
//        if segementItem.numberOfSegments == 0{
//            region = MKCoordinateRegionMake(center, span)
//        }else{
//            center = CLLocationCoordinate2DMake(longa, lati)
//            region = MKCoordinateRegionMake(center, span)
//        }
        
        
        myMapView.setRegion(region, animated: true)
        
    }
    
    
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("callout Accessory Tapped!")
        
        let viewAnno = view.annotation
        let viewTitle: String = ((viewAnno?.title)!)!
        let viewSubTitle: String = ((viewAnno?.subtitle)!)!
        
        print("\(viewTitle) \(viewSubTitle)")
        
        let ac = UIAlertController(title: viewTitle, message: viewSubTitle, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        var  annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            
            
            //            print("아노테이션 : \(annotation.subtitle)")
            
            
        }
        return annotationView
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        region.center = myMapView.userLocation.coordinate
        myMapView.setRegion(region, animated: true)
        print("\(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
