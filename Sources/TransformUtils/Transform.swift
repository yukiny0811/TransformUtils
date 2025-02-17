//
//  Transform.swift
//  TransformUtils
//
//  Created by Yuki Kuwashima on 2025/02/17.
//

import simd

public struct Transform {

    public var position: f3 {
        didSet {
            self.modelToWorldMatrix = calculateModelToWorldMatrix()
        }
    }
    public var rotation: f3 {
        didSet {
            self.modelToWorldMatrix = calculateModelToWorldMatrix()
        }
    }
    public var scale: f3 {
        didSet {
            self.modelToWorldMatrix = calculateModelToWorldMatrix()
        }
    }

    private(set) public var modelToWorldMatrix: f4x4 = .identity {
        didSet {
            self.modelToWorldNormalMatrix = calculateModelToWorldNormalMatrix()
        }
    }

    private(set) public var modelToWorldNormalMatrix: f4x4 = .identity

    public init(position: f3, rotation: f3, scale: f3) {
        self.position = position
        self.rotation = rotation
        self.scale = scale
        self.modelToWorldMatrix = calculateModelToWorldMatrix()
        self.modelToWorldNormalMatrix = calculateModelToWorldNormalMatrix()
    }

    private func calculateModelToWorldMatrix() -> f4x4 {
        var temporalModelMatrix: f4x4 = f4x4.identity
        temporalModelMatrix *= f4x4.createTranslation(position.x, position.y, position.z)
        temporalModelMatrix *= f4x4.createRotation(angle: rotation.z, axis: f3(0, 0, 1))
        temporalModelMatrix *= f4x4.createRotation(angle: rotation.y, axis: f3(0, 1, 0))
        temporalModelMatrix *= f4x4.createRotation(angle: rotation.x, axis: f3(1, 0, 0))
        temporalModelMatrix *= f4x4.createScale(scale.x, scale.y, scale.z)
        return temporalModelMatrix
    }

    private func calculateModelToWorldNormalMatrix() -> f4x4 {
        return modelToWorldMatrix.inverse.transpose
    }
}
