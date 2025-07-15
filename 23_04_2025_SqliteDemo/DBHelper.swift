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
}
