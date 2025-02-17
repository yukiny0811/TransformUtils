//
//  SimdTransform.swift
//  TransformUtils
//
//  Created by Yuki Kuwashima on 2025/02/17.
//

import simd

public extension f4x4 {

    /**
     Creates a view matrix that transforms world coordinates to camera coordinates.

     This method generates a "look-at" matrix using the specified eye position, center point, and up vector.

     - Parameters:
       - eye: The position of the camera.
       - center: The point in space the camera is looking at.
       - up: The up direction vector.
     - Returns: A 4x4 view matrix.
     */
    static func createLookAt(eye: f3, lookAt: f3, up: f3) -> f4x4 {
        let zAxis = simd_normalize(eye - lookAt)
        let xAxis = simd_normalize(simd_cross(up, zAxis))
        let yAxis = simd_cross(zAxis, xAxis)
        return f4x4(
            f4(xAxis.x, yAxis.x, zAxis.x, 0),
            f4(xAxis.y, yAxis.y, zAxis.y, 0),
            f4(xAxis.z, yAxis.z, zAxis.z, 0),
            f4(-simd_dot(xAxis, eye),
               -simd_dot(yAxis, eye),
               -simd_dot(zAxis, eye),
               1)
        )
    }

    /**
     Creates a translation matrix.

     This matrix translates coordinates by the given x, y, and z offsets.

     - Parameters:
       - x: The translation along the x-axis.
       - y: The translation along the y-axis.
       - z: The translation along the z-axis.
     - Returns: A 4x4 translation matrix.
     */
    static func createTranslation(
        _ x: Float,
        _ y: Float,
        _ z: Float
    ) -> f4x4 {
        return Self.init(
            f4(1, 0, 0, 0),
            f4(0, 1, 0, 0),
            f4(0, 0, 1, 0),
            f4(x, y, z, 1)
        )
    }

    /**
     Creates a rotation matrix.

     This method constructs a rotation matrix using the specified angle and rotation axis.

     - Parameters:
       - angle: The rotation angle in radians.
       - axis: The axis around which to rotate.
     - Returns: A 4x4 rotation matrix.
     */
    static func createRotation(
        angle: Float,
        axis: f3
    ) -> f4x4 {
        return Self.init(
            simd_quatf(angle: angle, axis: axis)
        )
    }

    /**
     Creates a scaling matrix.

     This matrix scales coordinates by the specified factors along the x, y, and z axes.

     - Parameters:
       - x: The scaling factor along the x-axis.
       - y: The scaling factor along the y-axis.
       - z: The scaling factor along the z-axis.
     - Returns: A 4x4 scaling matrix.
     */
    static func createScale(
        _ x: Float,
        _ y: Float,
        _ z: Float
    ) -> f4x4 {
        return Self.init(
            f4(x, 0, 0, 0),
            f4(0, y, 0, 0),
            f4(0, 0, z, 0),
            f4(0, 0, 0, 1)
        )
    }

    /**
     Creates a perspective projection matrix.

     This method constructs a matrix for perspective projection using the specified field of view, aspect ratio, near clipping plane, and far clipping plane.

     - Parameters:
       - fov: The field of view in radians.
       - aspect: The aspect ratio of the view (width divided by height).
       - near: The distance to the near clipping plane.
       - far: The distance to the far clipping plane.
     - Returns: A 4x4 perspective projection matrix.
     */
    static func createPerspective(
        fov: Float,
        aspect: Float,
        near: Float,
        far: Float
    ) -> f4x4 {
        let f: Float = 1.0 / tan(fov / 2.0)
        return Self.init(
            f4(f / aspect, 0, 0, 0),
            f4(0, f, 0, 0),
            f4(0, 0, (near + far) / (near - far), -1),
            f4(0, 0, (2 * near * far) / (near - far), 0)
        )
    }

    /**
     Creates an orthographic projection matrix.

     This method constructs an orthographic projection matrix using the specified left, right, bottom, top, near, and far clipping plane values.

     - Parameters:
       - l: The coordinate for the left vertical clipping plane.
       - r: The coordinate for the right vertical clipping plane.
       - b: The coordinate for the bottom horizontal clipping plane.
       - t: The coordinate for the top horizontal clipping plane.
       - n: The distance to the near clipping plane.
       - f: The distance to the far clipping plane.
     - Returns: A 4x4 orthographic projection matrix.
     */
    static func createOrthographic(
        _ l: Float,
        _ r: Float,
        _ b: Float,
        _ t: Float,
        _ n: Float,
        _ f: Float
    ) -> f4x4 {
        return Self.init(
            f4(2/(r-l), 0, 0, 0),
            f4(0, 2/(t-b), 0, 0),
            f4(0, 0, -2/(f-n), 0),
            f4(-(r+l)/(r-l), -(t+b)/(t-b), -(f+n)/(f-n), 1)
        )
    }

    static let identity = Self.init(
        f4(1, 0, 0, 0),
        f4(0, 1, 0, 0),
        f4(0, 0, 1, 0),
        f4(0, 0, 0, 1)
    )
}
