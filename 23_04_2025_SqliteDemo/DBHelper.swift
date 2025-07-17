//
//  DBHelper.swift
//  23_04_2025_SqliteDemo
//
//  Created by Vishal Jagtap on 14/07/25.
//

import Foundation
import SQLite3

final class DBHelper {
    static let shared = DBHelper()
    var db : OpaquePointer?
    var dbPath = "mydatabase1.sqlite"
    var employees : [Employee] = []
    
    init(){
        createDatabase()
        createTable()
    }
    
    func createDatabase(){
        do{
            var filePath = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false).appendingPathComponent(dbPath)
            
            if sqlite3_open(filePath.path,&db) == SQLITE_OK{
                print("Database is successfully created")
            }else{
                print("Database creation failed")
            }
        }catch{
           print(error)
        }
    }
    
    func createTable(){
        var createQueryString = "CREATE TABLE IF NOT EXISTS EMPLOYEE(EmpId INTEGER, EmpName TEXT);"
        
        var createStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db,
                           createQueryString,
                           -1,
                           &createStatement,
                           nil) == SQLITE_OK{
            print("Query Preparation is successful")
            if sqlite3_step(createStatement) == SQLITE_DONE{
                print("Table Creation is successful")
            }else{
                print("Table Creation is unsuccessful")
            }
        }else{
            print("Query Preparation is unsuccessful")
        }
        sqlite3_finalize(createStatement)
    }
    
    func insertEmployeeRecords(empId : Int, empName : String){
        let insertQueryString = "INSERT INTO EMPLOYEE(EmpId, EmpName) VALUES(?,?);"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            print("Insert Statement Prepapration is successful")
            
            sqlite3_bind_int(insertStatement,
                             1,
                             Int32(empId))
            
            sqlite3_bind_text(insertStatement,
                              2,
                              (empName as NSString).utf8String,
                              -1,
                              nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Employee Record inserted Successfully")
            }else{
                print("Employee rcord insertion unsuccessful")
            }
        } else {
            print("Insert Statement Preparation is unsuccessful")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func retriveEmployeeRecords() -> [Employee]{
        let retriveQuesryString = "SELECT * FROM EMPLOYEE;"
        let retriveQueryString1 = "SELECT * FROM EMPLOYEE ORDER BY EmpId ASC;"
        let retirveQueryString2 = "SELECT (EmpId,EmpName) FROM EMPLOYEE;"
        let retriveQueryString3 = "SELECT * FROM EMPLOYEE ORDER BY EmpId DESC;"

        var retriveStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              retriveQuesryString,
                              -1,
                              &retriveStatement,
                              nil) == SQLITE_OK{
            print("Retrive Statement Prepapration is successful")
            
            while sqlite3_step(retriveStatement) == SQLITE_ROW{
                let extractedEmpId = sqlite3_column_int(retriveStatement, 0)
                let extractedEmpName = sqlite3_column_text(retriveStatement, 1)
            
                let extractedName : String = String(describing: String(cString: extractedEmpName!))
                
                let newEmployeeObject = Employee(empId: Int(extractedEmpId), empName: extractedName)
                self.employees.append(newEmployeeObject)
            }
            
        } else {
            print("Retrive Statement Preparation Unsuccessful")
        }
        
        return self.employees
    }
        
    func deleteEmployeeRecords(empId : Int){
        let deleteQueryString = "DELETE FROM EMPLOYEE where EmpId = ?;"
        
        var deleteStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              deleteQueryString,
                              -1,
                              &deleteStatement,
                              nil) == SQLITE_OK{
            print("Delete Query Prepared Successfully")
            
            sqlite3_bind_int(deleteStatement, 1, Int32(empId))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("Employee record deleted successfully")
            }else{
                print("Employee recird deletion unsuccessful")
            }
        } else {
            print("Delete Quesry Preparation unsucessful")
        }
        sqlite3_finalize(deleteStatement)
    }
}
