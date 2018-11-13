//
//  TextViewViewController.swift
//  RXSwiftExample
//
//  Created by mac bokk pro on 2018-11-06.
//  Copyright © 2018 mac bokk pro. All rights reserved.
//

import UIKit
import RxSwift
import  RxCocoa

class TextViewViewController: UIViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    //var tableItems  =  TableViewItems()

    @IBOutlet weak var makeLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTextFeildWithRx(textFeild: email, placeholder: "enter email ", tag: 0)
        prepareTextFeildWithRx(textFeild: phone, placeholder: "enter phone  ", tag: 1)
        prepareTextFeildWithRx(textFeild: address, placeholder: "enter address  ", tag: 2)
        
        makeLogin.rx.tap.bind{
            print("\(self.email.text!) \(self.phone.text!) \(self.address.text!)")
             TableViewItems.shard.allItems.value.append("www")
             TableViewItems.shard.allItems.value.append("www2")
             TableViewItems.shard.allItems.value.append("www3")
             TableViewItems.shard.allItems.value.append("www4")
            
            
            for  index in  0...20 {
                TableViewItems.shard.allItems.value.append("www\(index)")
            }
            
            self.performSegue(withIdentifier: "showHomePage", sender: nil)
            
        }
        
    }
    
    func prepareTextFeildWithRx  (textFeild  :  UITextField,placeholder : String ,tag : Int ){
        textFeild.tag = tag
        textFeild.placeholder  =  placeholder
        textFeild.rx.controlEvent([.editingDidEnd,.valueChanged])
            .asObservable()
            .subscribe(onNext: {
                if textFeild.text?.count !=  0 {
                if textFeild.tag == 0 {
                    print("email  \(textFeild.text!)")
                }
                else if textFeild.tag == 1{
                    print("phone  \(textFeild.text!)")
                }
                else {
                    print("address   \(textFeild.text!)")
                }
                }
                else {
                    print("no data enterd ")
                }
                }
            ).disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
