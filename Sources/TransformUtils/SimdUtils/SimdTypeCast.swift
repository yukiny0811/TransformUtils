//
//  SimdTypeCast.swift
//  TransformUtils
//
//  Created by Yuki Kuwashima on 2025/02/17.
//

import simd
import CoreGraphics

public extension CGPoint {
    /**
     Converts a CGPoint to a 2-component SIMD float vector.

     - Returns: A `simd_float2` (alias `f2`) representing the point, with `x` and `y` as Float values.
     */
    var f2Value: f2 {
        f2(Float(self.x), Float(self.y))
    }
}

public extension CGSize {
    /**
     Converts a CGSize to a 2-component SIMD float vector.

     - Returns: A `simd_float2` (alias `f2`) representing the size, with `width` and `height` as Float values.
     */
    var f2Value: f2 {
        f2(Float(self.width), Float(self.height))
    }
}

public extension f2 {
    /**
     Converts a 2-component SIMD float vector to a CGPoint.

     - Returns: A `CGPoint` with the vector's `x` and `y` components converted to CGFloat.
     */
    var cgPoint: CGPoint {
        CGPoint(x: CGFloat(x), y: CGFloat(y))
    }

    /**
     Converts a 2-component SIMD float vector to a CGSize.

     - Returns: A `CGSize` with the vector's `x` and `y` components converted to CGFloat as width and height respectively.
     */
    var cgSize: CGSize {
        CGSize(width: CGFloat(x), height: CGFloat(y))
    }
}

