//
//  Department.swift
//  AutomatingCloudKitDemo
//
//  Created by 雷军 on 2021/6/19.
//

import Foundation
import CloudKit

class Department {
    let id: CKRecord.ID
    var address: String?
    var name: String?
    var phone: [String] = []
    var employees: [CKRecord.Reference] = []
    
    init(record: CKRecord) {
        id = record.recordID
        address = record["address"] as? String
        name = record["name"] as? String
        phone = record["phone"] as? [String] ?? []
        employees = record["employees"] as? [CKRecord.Reference] ?? []
    }
}
