//
//  ViewController.swift
//  23_04_2025_SqliteDemo
//
//  Created by Vishal Jagtap on 14/07/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let dbHelper = DBHelper.shared
//        dbHelper.insertEmployeeRecords(empId: 1007, empName: "Suchita")
//        dbHelper.insertEmployeeRecords(empId: 1006, empName: "Saurabh")
//        dbHelper.insertEmployeeRecords(empId: 1005, empName: "Heet")
//        dbHelper.insertEmployeeRecords(empId: 1009, empName: "Prajakta")
//        dbHelper.insertEmployeeRecords(empId: 1010, empName: "Krishna")
        
           dbHelper.insertEmployeeRecords(empId: 1012, empName: "Sakshi")
           dbHelper.insertEmployeeRecords(empId: 1016, empName: "Pooja")
           dbHelper.insertEmployeeRecords(empId: 1015, empName: "Priyanka")
           dbHelper.insertEmployeeRecords(empId: 1019, empName: "Shruti")
           dbHelper.insertEmployeeRecords(empId: 1020, empName: "Akshay")
        
        for eachEmp in dbHelper.retriveEmployeeRecords(){
            print("emp id is : \(eachEmp.empId) -- emp name is : \(eachEmp.empName)")
        }
        
//        dbHelper.deleteEmployeeRecords(empId: 1007)
        
        for eachEmp in dbHelper.retriveEmployeeRecords(){
            print("emp id is : \(eachEmp.empId) -- emp name is : \(eachEmp.empName)")
        }
    }
}
