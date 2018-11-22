//
//  Clamp.swift
//  FarmFundr
//
//  Created by Anupriya on 21/11/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//


import Foundation

extension Comparable {
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        return min(max(self, lowerBound), upperBound)
    }
}
