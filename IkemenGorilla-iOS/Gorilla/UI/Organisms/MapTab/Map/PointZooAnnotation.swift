//
//  PointZooAnnotation.swift
//  Gorilla
//
//  Created by admin on 2020/06/17.
//  Copyright © 2020 admin. All rights reserved.
//

import MapKit

class PointZooAnnotation: MKPointAnnotation {
    let zoo: Zoo
    
    init(zoo: Zoo) {
        self.zoo = zoo
        super.init()
    }
}

extension PointZooAnnotation {
    static func == (lhs: PointZooAnnotation, rhs: PointZooAnnotation) -> Bool{
        return lhs.zoo.id == rhs.zoo.id
    }
}
