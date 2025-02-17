//
//  SimdRandomPoint.swift
//  TransformUtils
//
//  Created by Yuki Kuwashima on 2025/02/17.
//

import simd

public extension f2 {
    /**
     Returns a random 2-component vector (`simd_float2`) with each component selected uniformly from the specified range.

     - Parameter range: The closed range from which to generate each component.
     - Returns: A `simd_float2` with random components.
     */
    static func randomPoint(_ range: ClosedRange<Float>) -> Self {
        return Self(
            Float.random(in: range),
            Float.random(in: range)
        )
    }
}

public extension f3 {
    /**
     Returns a random 3-component vector (`simd_float3`) with each component selected uniformly from the specified range.

     - Parameter range: The closed range from which to generate each component.
     - Returns: A `simd_float3` with random components.
     */
    static func randomPoint(_ range: ClosedRange<Float>) -> Self {
        return Self(
            Float.random(in: range),
            Float.random(in: range),
            Float.random(in: range)
        )
    }
}

public extension f4 {
    /**
     Returns a random 4-component vector (`simd_float4`) with each component selected uniformly from the specified range.

     - Parameter range: The closed range from which to generate each component.
     - Returns: A `simd_float4` with random components.
     */
    static func randomPoint(_ range: ClosedRange<Float>) -> Self {
        return Self(
            Float.random(in: range),
            Float.random(in: range),
            Float.random(in: range),
            Float.random(in: range)
        )
    }
}
