//
//  SimdMemorySize.swift
//  TransformUtils
//
//  Created by Yuki Kuwashima on 2025/02/17.
//

import simd

public extension f2 {
    /// The memory size (in bytes) of a 2-component vector (`simd_float2`), as determined by its stride.
    static var memorySize: Int {
        return MemoryLayout<Self>.stride
    }
}

public extension f3 {
    /// The memory size (in bytes) of a 3-component vector (`simd_float3`), as determined by its stride.
    static var memorySize: Int {
        return MemoryLayout<Self>.stride
    }
}

public extension f4 {
    /// The memory size (in bytes) of a 4-component vector (`simd_float4`), as determined by its stride.
    static var memorySize: Int {
        return MemoryLayout<Self>.stride
    }
}

public extension f2x2 {
    /// The memory size (in bytes) of a 2x2 matrix (`simd_float2x2`), as determined by its stride.
    static var memorySize: Int {
        return MemoryLayout<Self>.stride
    }
}

public extension f3x3 {
    /// The memory size (in bytes) of a 3x3 matrix (`simd_float3x3`), as determined by its stride.
    static var memorySize: Int {
        return MemoryLayout<Self>.stride
    }
}

public extension f4x4 {
    /// The memory size (in bytes) of a 4x4 matrix (`simd_float4x4`), as determined by its stride.
    static var memorySize: Int {
        return MemoryLayout<Self>.stride
    }
}
