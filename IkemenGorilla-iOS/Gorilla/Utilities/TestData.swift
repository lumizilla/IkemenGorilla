//
//  TestData.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol TestDataType {
    static func contest() -> Contest
    static func contests(count: Int) -> [Contest]
    static func contestDetail() -> ContestDetail
    static func zoo() -> Zoo
    static func zoos(count: Int) -> [Zoo]
    static func sponsor() -> Sponsor
    static func sponsors(count: Int) -> [Sponsor]
    static func entry() -> Entry
    static func entries(count: Int) -> [Entry]
    static func post() -> Post
    static func posts(count: Int) -> [Post]
    static func award() -> Award
    static func awards(count: Int) -> [Award]
    static func contestResult(numberOfVotes: Int, maxOfVotes: Int) -> ContestResult
    static func contestResults(count: Int) -> [ContestResult]
    static func animal() -> Animal
    static func animals(count: Int) -> [Animal]
    static func zooAnimal() -> ZooAnimal
    static func zooAnimals(count: Int) -> [ZooAnimal]
    static func profile() -> Profile
    static func profiles(count: Int) -> [Profile]
    
    // Response
    static func contestAnimalDetailResponse() -> ContestAnimalDetailResponse
}

struct TestData: TestDataType {
    static func contest() -> Contest {
        return Contest(
            id: testID(),
            name: "イケメンゴリラコンテスト",
            start: dateFromString(from: "2020-05-01"),
            end: dateFromString(from: "2020-05-30"),
            status: "開催中",
            catchCopy: "ワシが一番イケメンやで",
            imageUrl: "https://images.unsplash.com/photo-1581281863883-2469417a1668?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=989&q=80"
        )
    }
    
    static func contests(count: Int) -> [Contest] {
        return (0 ..< count).map { _ in contest() }
    }
    
    static func contestDetail() -> ContestDetail {
        return ContestDetail(
            id: testID(),
            name: "イケメンゴリラコンテスト",
            start: dateFromString(from: "2020-05-01"),
            end: dateFromString(from: "2020-05-30"),
            status: "開催中",
            catchCopy: "ワシが一番イケメンやで",
            description: "一番イケメンなゴリラは誰だ！！！人々を一番キュンキュンさせるゴリラは誰なのか！全国から数々のイケメンゴリラが遂に集結．決戦のときがやってきた！",
            imageUrl: "https://images.unsplash.com/photo-1581281863883-2469417a1668?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=989&q=80",
            numberOfEntries: 16,
            numberOfVotedPeople: 121,
            numberOfVotes: 382
        )
    }
    
    static func zoo() -> Zoo {
        return Zoo(
            id: testID(),
            name: "東山動物園",
            address: "愛知県名古屋市千種区東山元町３丁目７０",
            latitude: randomLatitude(),
            longitude: randomLongitude(),
            imageUrl: "https://images.unsplash.com/reserve/wrev1ljvQ6KlfyljCQG0_lion.jpg?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1955&q=80"
        )
    }
    
    static func zoos(count: Int) -> [Zoo] {
        return (0 ..< count).map { _ in zoo() }
    }
    
    static func sponsor() -> Sponsor {
        return Sponsor(
            id: testID(),
            name: "Red Bull",
            imageUrl: "https://www.screenja.com/static/img/thumbs/red-bull-logo-1-normal-636.png",
            websiteUrl: "https://www.redbull.com/jp-ja/"
        )
    }
    
    static func sponsors(count: Int) -> [Sponsor] {
        return (0 ..< count).map { _ in sponsor() }
    }
    
    static func entry() -> Entry {
        return Entry(
            animalId: testID(),
            name: "シャバーニ",
            iconUrl: "https://images.unsplash.com/photo-1563485906266-9b9a5ca03f07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=582&q=80",
            zooName: "東山動物園"
        )
    }
    
    static func entries(count: Int) -> [Entry] {
        return (0 ..< count).map { _ in entry() }
    }
    
    static func post() -> Post {
        return Post(
            id: testID(),
            animalId: testID(),
            animalName: "メリーさんの羊",
            animalIconUrl: "https://images.unsplash.com/photo-1484557985045-edf25e08da73?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=1934&q=80",
            zooId: testID(),
            zooName: "東山動物園",
            imageUrl: TestData.postImageUrl(),
            description: "Mary had a little lamb\nLittle lamb, little lamb,\nMary had a little lamb\nIts fleece was white as snow. ♪♫♬🎶",
            createdAt: dateFromString(from: "2020-05-24")
        )
    }
    
    static func posts(count: Int) -> [Post] {
        return (0 ..< count).map { _ in post() }
    }
    
    static func award() -> Award {
        return Award(
            animalId: testID(),
            animalName: "シャバーニ",
            iconUrl: "https://images.unsplash.com/photo-1563485906266-9b9a5ca03f07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=582&q=80",
            awardName: "グランプリ"
        )
    }
    
    static func awards(count: Int) -> [Award] {
        return (0 ..< count).map { _ in award() }
    }
    
    static func contestResult(numberOfVotes: Int, maxOfVotes: Int) -> ContestResult {
        return ContestResult(
            animalId: testID(),
            animalName: "シャバーニ",
            iconUrl: "https://images.unsplash.com/photo-1563485906266-9b9a5ca03f07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=582&q=80",
            numberOfVotes: numberOfVotes,
            maxOfVotes: maxOfVotes
        )
    }
    
    static func contestResults(count: Int) -> [ContestResult] {
        let range = 31
        let max = count * range
        return (0 ..< count).map { index in contestResult(numberOfVotes: range * (count - index), maxOfVotes: max) }
    }
    
    static func profile() -> Profile {
        return Profile(
            id: testID(),
            name: "Akihiro Kokubo",
            imageUrl: "https://imgur.com/UHAjkys",
            numberOfAnimals: 5,
            animalId: testID(),
            animalName: "メリーさんの羊",
            animalIconUrl: "https://images.unsplash.com/photo-1484557985045-edf25e08da73?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=1934&q=80",
            zooId: testID(),
            zooName: "東山動物園",
            numberOfContests: 5,
            contestId: testID(),
            contestName: "イケメンゴリラコンテスト",
            contestStart:dateFromString(from: "2020-05-01"),
            contestEnd: dateFromString(from: "2020-05-30"),
            contestIconUrl: "https://images.unsplash.com/photo-1581281863883-2469417a1668?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=989&q=80",
            likedId: testID(),
            likedIconUrl: "https://images.unsplash.com/reserve/wrev1ljvQ6KlfyljCQG0_lion.jpg?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1955&q=80",
            likedZooId: testID(),
            likedZooName: "東山動物園"
        )
    }
    
    static func profiles(count: Int) -> [Profile] {
        return (0 ..< count).map { _ in profile() }
    }
    
    static func contestAnimalDetailResponse() -> ContestAnimalDetailResponse {
        return ContestAnimalDetailResponse(
            animalId: testID(),
            animalName: "シャバーニ",
            animalIconUrl: "https://images.unsplash.com/photo-1563485906266-9b9a5ca03f07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=582&q=80",
            description: "現在ニシゴリラの群れのリーダーを務めているのがシャバーニ氏。グループのメス、ネネとアイの間に1頭ずつ子どもがいる二児のパパです。精悍な顔つきと筋肉隆々のしなやかな肉体、たまに見せるアンニュイな表情は、人間の女性にもズキューンッ！と刺さります。",
            zooId: testID(),
            zooName: "東山動物園",
            zooAddress: "愛知県名古屋市千種区東山元町３丁目７０",
            isVotedToday: false
        )
    }
    
    static func animal() -> Animal {
        return Animal(
            id: testID(),
            name: "メリーさんの羊",
            iconUrl: "https://images.unsplash.com/photo-1484557985045-edf25e08da73?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1567&q=80",
            sex: "オス",
            birthday: Date.init(),
            description: "普段は乾草か牧草かお手紙を食べています．いとこは基本全員イギリス南東部にいます．自分だけ日本にきちゃいました．指の数は前が2本，後ろが2本です．いいでしょ．寝るときはふせて寝ます．仰向けにはなりません．",
            numberOfFans: 312,
            isFan: false,
            zooName: "東山動物園"
        )
    }
    
    static func animals(count: Int) -> [Animal] {
        return (0 ..< count).map { _ in animal() }
    }
    
    static func zooAnimal() -> ZooAnimal {
        return ZooAnimal(
            id: testID(),
            name: "ボム",
            iconUrl: "https://images.unsplash.com/photo-1484557985045-edf25e08da73?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1567&q=80",
            isFan: false
        )
    }
    
    static func zooAnimals(count: Int) -> [ZooAnimal] {
        return (0 ..< count).map { _ in zooAnimal() }
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
    
    private static func postImageUrl() -> String {
        let urls = [
            "https://images.unsplash.com/photo-1533415648777-407b626eb0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
            "https://images.unsplash.com/photo-1576626884826-44e68ad6c948?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjE1ODB9",
            "https://images.unsplash.com/photo-1560709446-0e44df609ebc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1300&q=80"
        ]
        return urls[Int.random(in: 0 ..< 3)]
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
