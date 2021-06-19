//
//  ViewController.swift
//  AutomatingCloudKitDemo
//
//  Created by 雷军 on 2021/6/15.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CKContainer.default().accountStatus { [weak self] accountStatus, error in
            guard let `self` = self else { return }
            
            if accountStatus == .noAccount {
                DispatchQueue.main.async {
                    let message =
                        "iCloud未登录，请先去设置中心登录iCloud"
                    let alert = UIAlertController(
                        title: "iCloud未登录",
                        message: message,
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
            else {
                self.fetchData()
            }
        }
    }


}

extension ViewController {
    private func fetchData() {
        
    }
}
