# Busan-Public-Free-Food-Map-Static-Table-Cell
* SingleMapTableViewController의 TableView Cell의 속성을 static cell로 사용
* 이때 각 static cell을 outlet 변수를 설정하여 해당 값(급식일, 급식대상, 운영기관, 전화번호)을 넣는다.
<pre><code>  
@IBOutlet weak var sMealDay: UITableViewCell!
@IBOutlet weak var sTarget: UITableViewCell!
@IBOutlet weak var sManageNm: UITableViewCell!
@IBOutlet weak var sPhone: UITableViewCell! 
---
self.title = sLoc
sMealDay.textLabel?.text = "급식일"
sMealDay.detailTextLabel?.text = sItem["mealDay"]
sTarget.textLabel?.text = "급식대상"
sTarget.detailTextLabel?.text = sItem["target"]
sManageNm.textLabel?.text = "운영기관"
sManageNm.detailTextLabel?.text = sItem["manageNm"]
sPhone.textLabel?.text = "전화번호"
sPhone.detailTextLabel?.text = sItem["phone"]
</code></pre>

![Alt text](https://jhkim3217.gitbooks.io/busan-open-data-app-dev/content/assets/static-cell-STB.png)

![Alt text](https://jhkim3217.gitbooks.io/busan-open-data-app-dev/content/assets/static_cell_att.png)

![Alt text](https://jhkim3217.gitbooks.io/busan-open-data-app-dev/content/assets/statci-cell01.jpg)
![Alt text](https://jhkim3217.gitbooks.io/busan-open-data-app-dev/content/assets/statci-cell02.jpg)
![Alt text](https://jhkim3217.gitbooks.io/busan-open-data-app-dev/content/assets/statci-cell03.jpg)
![Alt text](https://jhkim3217.gitbooks.io/busan-open-data-app-dev/content/assets/statci-cell04.jpg)
