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
    
    private var list: [Department] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        CKContainer.default().accountStatus { accountStatus, error in

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

// MARK: fetchData
extension ViewController {
    @IBAction func refreshAction(_ sender: Any) {
        self.fetchData()
    }
    
    private func fetchData() {
        let query = CKQuery(recordType: "Department", predicate: NSPredicate(value: true))

        CKContainer.default().privateCloudDatabase.fetch(withQuery: query) { result in
            
            do {
                let match = try result.get()
                self.list = try match.matchResults.values
                    .compactMap {
                        $0.map { Department(record: $0) }
                    }
                    .compactMap {
                       try $0.get()
                    }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    let message = error.localizedDescription
                    let alert = UIAlertController(
                        title: "获取iCloud数据失败",
                        message: message,
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .cancel))
                    self.present(alert, animated: true)
                }
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: TableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        
        let model = list[indexPath.row]
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
