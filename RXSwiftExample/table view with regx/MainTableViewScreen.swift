//
//  ViewController.swift
//  RXSwiftExample
//
//  Created by mac bokk pro on 2018-10-31.
//  Copyright © 2018 mac bokk pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainTableViewScreen: UIViewController {
    let disposeBag = DisposeBag()
    
     var allData =  Variable([SectionModel(model: "title1", items: ["a", "aasas", "dsdsd"]),SectionModel(model: "title2", items: ["a", "aasas", "dsdsd"])])
    
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
                cell.title.text = item
                return cell
            })
    
    @IBOutlet weak var tbMain: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // regist cell to tableview
        tbMain.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        dataSource.titleForHeaderInSection = {
            dataSource , index in
            return   dataSource.sectionModels[index].model
        }
        tbMain.rowHeight   =  200
        tbMain.sectionFooterHeight = 20
        // use to  make any  change in  rows such  as delete
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath  in
            return true
        }
        
           allData.asObservable().bind(to: tbMain.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        // for delete rows
        tbMain.rx.itemDeleted
            .map { indexPath in
                return (indexPath, self.dataSource[indexPath])
            }
            .subscribe(onNext: { index in
                var deletedItem   = self.allData.value[index.0.section]
                  deletedItem.items.remove(at: index.0.row)
                self.allData.value.remove(at:index.0.section )
                self.allData.value.insert(deletedItem, at: index.0.section)
            })
            .disposed(by: disposeBag)
        
        tbMain.rx.itemSelected
            .map { indexPath in
                return (indexPath, self.dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                print("Tapped \(pair.1) @ \(pair.0)")
            })
            .disposed(by: disposeBag)
        
        // set delegation  for tabel
            tbMain.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    
    @IBAction func addItems(_ sender: UIButton) {
        allData.value.append(SectionModel(model: "title1", items: ["new one ", "aasas", "dsdsd"]))
       // TableViewItems.shard.allItems.value.append("www \( TableViewItems.shard.allItems.value.count + 1)")
    }
    

}

extension MainTableViewScreen :  UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  view  = UIView(frame: CGRect(x:0, y: 0, width:tableView.frame.width, height: 50))
        view.backgroundColor = UIColor.red
        let  label  = UILabel(frame: CGRect(x:0, y: 0, width:tableView.frame.width, height: 100))
        label.text =  "section \(section)"
        view.addSubview(label)
        return   view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  100
    }
}


