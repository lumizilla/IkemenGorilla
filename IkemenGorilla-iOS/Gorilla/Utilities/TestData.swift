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
    static func testContests(count: Int) -> [Contest]
    static func testZoo() -> Zoo
    static func testZoos(count: Int) -> [Zoo]
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
    
    static func testContests(count: Int) -> [Contest] {
        return (0 ..< count).map { _ in testContest() }
    }
    
    static func testZoo() -> Zoo {
        return Zoo(
            id: testID(),
            name: "東山動物園",
            address: "愛知県名古屋市千種区東山元町３丁目７０",
            latitude: randomLatitude(),
            longitude: randomLongitude(),
            imageUrl: "https://images.unsplash.com/reserve/wrev1ljvQ6KlfyljCQG0_lion.jpg?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1955&q=80"
        )
    }
    
    static func testZoos(count: Int) -> [Zoo] {
        return (0 ..< count).map { _ in testZoo() }
    }
    
    // MARK: - Private functions
    
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
    
    private static func randomLatitude() -> Double {
        return 34.5 + Double.random(in: 0 ..< 1)
    }
    
    private static func randomLongitude() -> Double {
        return 135.6 + Double.random(in: 0 ..< 1)
    }
}
