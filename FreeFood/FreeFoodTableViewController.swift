//
//  FreeFoodTableViewController.swift
//  FreeFood
//
//  Created by 김종현 on 2017. 11. 2..
//  Copyright © 2017년 김종현. All rights reserved.
//  XCode 8.3.3
//
////////////////////////////////////////////////
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

class FreeFoodTableViewController: UITableViewController,XMLParserDelegate {
    
    var list:[String:String] = [:]
    var data:[[String:String]] = []
    var key = ""
    var servieKey = "XRcD2BtScfry3R19eGO%2FNR7cx9DTbKu4EOQjZiaDgTC48fA6Y1R7unCSNHsnKVzpSjVPfYtXFuzwEPclYn0Rew%3D%3D"
    var listEndPoint = "http://data.jeonnam.go.kr/rest/namdotourist/getNdtrIslandList"
    let detailEndPoint = "http://data.jeonnam.go.kr/rest/namdotourist/getNdtrIslandView"
	
	var totalCount = 0 //총 갯수를 저장하는 변수
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "전라도 섬 정보"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
                
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("data.plist")
        
        //print(url)
		
		//시작할때마다 TotalCount를 받아옴
		getList(numOfRows: 0)
		
        if fileManager.fileExists(atPath: (url?.path)!) {
			//파일이 있으면 파일에서 읽어옴
			data = NSArray(contentsOf: url!) as! Array
			print("파일 있음")
			//파일에서 읽어본 갯수와 totalCount를 비교
//			if (data.count != totalCount) {
//				//파일에서 읽어본 갯수와 totalCount가 다르면(변화가 있으면) 다시 읽어와서 저장
//				getList(numOfRows: totalCount)
//				saveDetail(url: url!)
//            }
        } else {
			//******* 파일이 없으면
//			getList(numOfRows: totalCount)
//			saveDetail(url: url!)
            
            
            print("파일 없음")
            getList(numOfRows: totalCount)
       }
        
       tableView.reloadData()
    }
	
    
    
    
    
    
    
    
    
	func getList(numOfRows:Int) { //numOfRows를 입력
        //let str = detailEndPoint + "?serviceKey=\(servieKey)&numsofRows=20"
        let str = listEndPoint + "?serviceKey=\(servieKey)&pageSize=\(numOfRows)"
		
        print(str)
        
        if let url = URL(string: str) {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                let success = parser.parse()
                if success {
                    print("parse success in getList")
                    print("totalCount = \(totalCount)")
                    
                } else {
                    print("parse failed in hetList")
                }
            }
        }
    }
    
//    func getDetail(tourId: String) {
//        let str = detailEndPoint + "?serviceKey=\(servieKey)&tourId=\(tourId)"
//        
//        if let url = URL(string: str) {
//            if let parser = XMLParser(contentsOf: url) {
//                parser.delegate = self
//                let success = parser.parse()
//                if success {
//                    print("parse success in getDetail")
//                    //print(items)
//                    
//                } else {
//                    print("parse fail in getDeatil")
//                }
//            }
//        }
//    }
	
	//*******새로 추가된 함수 - 목록데이터를 가지고 상세데이터를 가져와서 저장하는 함수
	// Detail Data 가져오는 부분을 saveDetail 메소드로 extract
//	func saveDetail(url:URL) {
//		let tempItems = data  // tableView에서 재활용
//        //print("items = \(items)")
//		
//		data = []
//		
//        
//        //-----------------thread controll----------------------
//        //-------DispatchQueue선언(멀티 thread)-------------------
//        //qos 속성에 따라 우선순위 변경
//        let equeue = DispatchQueue(label:"com.yangsoo.queue", qos:DispatchQoS.userInitiated)
//        //-------xml parxer(background thread사용)---------------
//        equeue.async {
//            for dic in tempItems {
//                // 상세 목록 파싱
//                self.getDetail(tourId: dic["tourId"]!)
//                //-------tableview(main thread사용(ui는 main thread 사용 필수))---
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    let temp = self.data as NSArray  // NSArry는 화일로 저장하기 위함
//                    temp.write(to: url, atomically: true)
//                }
//            }
//            
//        }
//        //-----------------thread controll------------------------
//        
//        
//        
//        
//        
//        
//        
//        
//        
////		for dic in tempItems {
////			// 상세 목록 파싱
////			getDetail(tourId: dic["tourId"]!)
////		}
//		
////		let temp = data as NSArray  // NSArry는 화일로 저장하기 위함
////		temp.write(to: url, atomically: true)
////        
//	}
//
//    
//    
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //key = elementName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        key = elementName
        if key == "list" {
            list = [:]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // foundCharacters가 두번 호출
        if list[key] == nil {
            list[key] = string.trimmingCharacters(in: .whitespaces)
            //print("item(\(key)) = \(item[key])")
			
			//*******key가 totalCount 이면 totalCount 변수에 저장
			if key == "totalCount" {
				totalCount = Int(string.trimmingCharacters(in: .whitespaces))!
			}
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "list" {
            data.append(list)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        
        let dic = data[indexPath.row]
        cell.textLabel?.text = dic["tourNm"]
        cell.detailTextLabel?.text = dic["tourAddr"]

        return cell
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "goTotalMap" {
            let totalMVC = segue.destination as! TotalMapViewController
            totalMVC.tItems = data
            
        } else if segue.identifier == "goSingleMap" {
            let singleMTVC = segue.destination as! SingleMapTableViewController
            let selectedIndex = tableView.indexPathForSelectedRow
            singleMTVC.sItem = data[(selectedIndex?.row)!]
            
        }
     }
    
    
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

       
}
