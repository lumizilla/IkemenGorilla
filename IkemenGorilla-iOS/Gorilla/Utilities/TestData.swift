//
//  TestData.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol TestDataType {
    static func testContest() -> Contest
}

struct TestData: TestDataType {
    static func testContest() -> Contest {
        return Contest(
            id: testID(),
            name: "イケメンゴリラコンテスト",
            start: dateFromString(from: "2020-05-01"),
            end: dateFromString(from: "2020-05-30"),
            status: "開催中",
            catchCopy: "ワシが一番イケメンやで",
            description: "一番イケメンなゴリラは誰だ！！！人々を一番キュンキュンさせるゴリラは誰なのか！全国から数々のイケメンゴリラが遂に集結．決戦のときがやってきた！",
            imageUrl: "https://images.unsplash.com/photo-1581281863883-2469417a1668?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=989&q=80"
        )
    }
    
    private static func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
    
    private static func testID() -> String {
        return randomString(length: 32)
    }
    
    private static func dateFromString(from: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: from) ?? Date()
    }
}
