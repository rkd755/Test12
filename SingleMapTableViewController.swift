//
//  SingleMapTableViewController.swift
//  FreeFood
//
//  Created by 김종현 on 2017. 11. 16..
//  Copyright © 2017년 김종현. All rights reserved.
//
////////////////////////////////////////////////
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
////////////////////////////////////////////////////

import UIKit
import MapKit
import CoreLocation

class SingleMapTableViewController: UITableViewController, CLLocationManagerDelegate {
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet weak var sMealDay: UITableViewCell!
    @IBOutlet weak var sTarget: UITableViewCell!
    @IBOutlet weak var sManageNm: UITableViewCell!
    
    
    var sItem:[String:String] = [:]
    var sLat: Double?
    var sLong: Double?
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if sItem != nil{
            sLat = (sItem["tourYpos"]! as NSString).doubleValue
            sLong = (sItem["tourXpos"]! as NSString).doubleValue
            
            let sLoc = sItem["tourZoneNm"]
            let sAddr = sItem["tourAddr"]
            
            zoomToRegion()
            
            let anno = MKPointAnnotation()
            anno.coordinate.latitude = sLat!
            anno.coordinate.longitude = sLong!
            anno.title = sLoc
            anno.subtitle = sAddr
            
            myMapView.addAnnotation(anno)
            myMapView.selectAnnotation(anno, animated: true)
            
            self.title = sLoc
            sMealDay.textLabel?.text = "명칭"
            sMealDay.detailTextLabel?.text = sItem["tourNm"]
            sTarget.textLabel?.text = "메뉴명"
            sTarget.detailTextLabel?.text = sItem["tourMenuNm"]
            sManageNm.textLabel?.text = "전화번호"
            sManageNm.detailTextLabel?.text = sItem["tourTel"]
        }
        
        
    }
    
    func zoomToRegion() {
        // 35.162685, 129.064238
        let center = CLLocationCoordinate2DMake(sLat!, sLong!)
        let span = MKCoordinateSpanMake(0.9, 0.9)
        let region = MKCoordinateRegionMake(center, span)
        myMapView.setRegion(region, animated: true)
    }
    
    // 콘솔(print)로 현재 위치 변화 출력
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coor = manager.location?.coordinate
        print("latitute" + String(describing: coor?.latitude) + "/ longitude" + String(describing: coor?.longitude))
    }

    /*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "급식일"
        cell.detailTextLabel?.text = sItem["mealDay"]

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
