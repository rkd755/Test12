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
    
    @IBOutlet weak var myMapView: MKMapView!
    var locationManager: CLLocationManager!
    var tItems:[[String:String]] = []

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
        
        self.title = "부산 무료급식소 지도"
        zoomToRegion()
        
        //print("tItems = \(tItems)")
        // lat, lng
        var annos = [MKPointAnnotation]()
        
        for item in tItems {
            let anno = MKPointAnnotation()
            
            let lat = item["tourYpos"]
            let long = item["tourXpos"]
            
            if lat != nil {
                let fLat = (lat! as NSString).doubleValue
                let fLong = (long! as NSString).doubleValue
                
                anno.coordinate.latitude = fLat
                anno.coordinate.longitude = fLong
                anno.title = item["tourZoneNm"]
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
        let center = CLLocationCoordinate2DMake(35.162685, 129.083200)
        let span = MKCoordinateSpanMake(0.35, 0.44)
        let region = MKCoordinateRegionMake(center, span)
        myMapView.setRegion(region, animated: true)
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
