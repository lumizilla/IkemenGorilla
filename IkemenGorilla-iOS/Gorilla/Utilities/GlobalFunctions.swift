//
//  GlobalFunctions.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

func undefined<T>(_ message: String, function: String = #function, file: String = #file, line: UInt = #line) -> T {
    fatalError("\(message) [\(getPrettyFunction(function, file, line))]")
}

private func getPrettyFunction(_ function: String, _ file: String, _ line: UInt) -> String {
    if let filename = file.split(separator: "/").last {
        return filename + ":\(line) " + function
    } else {
        return file + ":\(line) " + function
    }
}
