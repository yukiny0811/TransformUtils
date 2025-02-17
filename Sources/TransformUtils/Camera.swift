//
//  Camera.swift
//  TransformUtils
//
//  Created by Yuki Kuwashima on 2025/02/17.
//

import simd

/// A structure that manages camera parameters along with view and perspective matrices.
public struct Camera: Equatable {

    /// The width of the frame. Updating this property triggers a recalculation of the perspective matrix.
    private(set) public var frameWidth: Float {
        didSet {
            updatePerspectiveMatrix()
        }
    }

    /// The height of the frame. Updating this property triggers a recalculation of the perspective matrix.
    private(set) public var frameHeight: Float {
        didSet {
            updatePerspectiveMatrix()
        }
    }

    /// The field of view in degrees. Updating this property triggers a recalculation of the perspective matrix.
    private(set) public var fovInDegrees: Float {
        didSet {
            updatePerspectiveMatrix()
        }
    }

    /// The distance to the near clipping plane. Updating this property triggers a recalculation of the perspective matrix.
    private(set) public var near: Float {
        didSet {
            updatePerspectiveMatrix()
        }
    }

    /// The distance to the far clipping plane. Updating this property triggers a recalculation of the perspective matrix.
    private(set) public var far: Float {
        didSet {
            updatePerspectiveMatrix()
        }
    }

    /// The position of the camera. Updating this property triggers a recalculation of the view matrix.
    private(set) public var eye: f3 {
        didSet {
            updateViewMatrix()
        }
    }

    /// The point the camera is looking at. Updating this property triggers a recalculation of the view matrix.
    private(set) public var lookAt: f3 {
        didSet {
            updateViewMatrix()
        }
    }

    /// The up direction of the camera. Updating this property triggers a recalculation of the view matrix.
    private(set) public var up: f3 {
        didSet {
            updateViewMatrix()
        }
    }

    /// The computed view matrix.
    private(set) public var viewMatrix: f4x4 = .identity
    /// The computed perspective matrix.
    private(set) public var perspectiveMatrix: f4x4 = .identity

    /// Initializes a new camera with the specified parameters.
    ///
    /// - Parameters:
    ///   - frameWidth: The width of the view frame.
    ///   - frameHeight: The height of the view frame.
    ///   - fovInDegrees: The field of view in degrees. Defaults to 85.
    ///   - near: The distance to the near clipping plane. Defaults to 0.01.
    ///   - far: The distance to the far clipping plane. Defaults to 1000.
    ///   - eye: The initial position of the camera. Defaults to (0, 0, 3).
    ///   - center: The initial point the camera is looking at. Defaults to (0, 0, 0).
    ///   - up: The up direction vector of the camera. Defaults to (0, 1, 0).
    public init(
        frameWidth: Float,
        frameHeight: Float,
        fovInDegrees: Float = 85,
        near: Float = 0.01,
        far: Float = 1000,
        eye: f3 = f3(0, 1, 3),
        lookAt: f3 = f3(0, 0, 0),
        up: f3 = f3(0, 1, 0)
    ) {
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.fovInDegrees = fovInDegrees
        self.near = near
        self.far = far
        self.eye = eye
        self.lookAt = lookAt
        self.up = up

        updatePerspectiveMatrix()
        updateViewMatrix()
    }

    /// Updates the view matrix using the current `eye`, `center`, and `up` values.
    ///
    /// Internally, it calls `f4x4.createLookAt` to generate the view matrix.
    private mutating func updateViewMatrix() {
        viewMatrix = f4x4.createLookAt(eye: eye, lookAt: lookAt, up: up)
    }

    /// Updates the perspective matrix using the current camera parameters.
    ///
    /// Internally, it calls `f4x4.createPerspective` with the field of view (converted to radians),
    /// the aspect ratio (calculated from `frameWidth` and `frameHeight`), and the near and far clipping planes.
    private mutating func updatePerspectiveMatrix() {
        perspectiveMatrix = f4x4.createPerspective(
            fov: Float.degreesToRadians(fovInDegrees),
            aspect: frameWidth / frameHeight,
            near: near,
            far: far
        )
    }

    /// Sets the frame dimensions and updates the perspective matrix if the dimensions change.
    ///
    /// - Parameters:
    ///   - width: The new width of the frame.
    ///   - height: The new height of the frame.
    public mutating func setFrame(width: Float, height: Float) {
        if self.frameWidth != width || self.frameHeight != height {
            self.frameWidth = width
            self.frameHeight = height
        }
    }

    /// Sets the field of view in degrees and updates the perspective matrix.
    ///
    /// - Parameter degrees: The new field of view in degrees.
    public mutating func setFov(to degrees: Float) {
        self.fovInDegrees = degrees
    }

    public mutating func setNear(_ value: Float) { self.near = value }
    public mutating func setFar(_ value: Float) { self.far = value }
    public mutating func setEye(_ value: f3) { self.eye = value }
    public mutating func setLookAt(_ value: f3) { self.lookAt = value }
    public mutating func setUp(_ value: f3) { self.up = value }

    /// Sets the camera's position, the point it looks at, and the up vector, then updates the view matrix.
    ///
    /// - Parameters:
    ///   - eye: The new position of the camera.
    ///   - center: The new point the camera is looking at.
    ///   - up: The new up direction vector for the camera.
    public mutating func update(eye: f3, lookAt: f3, up: f3) {
        self.eye = eye
        self.lookAt = lookAt
        self.up = up
    }

    /// Orbits the camera around a specified center point.
    ///
    /// This method updates the camera's position based on an orbit around a given center point,
    /// modifying the distance, yaw (horizontal angle), and pitch (vertical angle).
    ///
    /// - Parameters:
    ///   - center: The point around which the camera orbits.
    ///   - distanceDelta: The change in distance between the camera and the center. A positive value moves the camera away, and a negative value moves it closer.
    ///   - xDelta: The change in the yaw angle (in radians).
    ///   - yDelta: The change in the pitch angle (in radians).
    public mutating func orbitCamera(lookAt: f3, distanceDelta: Float, xDelta: Float, yDelta: Float) {
        // Calculate the current offset and radius from the camera's position to the center point.
        let offset = self.eye - lookAt
        let radius = simd_length(offset)

        // Compute the current yaw and pitch angles.
        let currentYaw = atan2(offset.x, offset.z)
        let currentPitch = asin(offset.y / radius)

        // Adjust the yaw and pitch by the provided deltas.
        let newYaw = currentYaw + xDelta
        var newPitch = currentPitch + yDelta

        // Constrain the pitch angle to avoid gimbal lock (limit to ±(π/2 - 0.001)).
        let pitchLimit = Float.pi / 2 - 0.001
        newPitch = max(min(newPitch, pitchLimit), -pitchLimit)

        // Compute the new radius, ensuring it does not drop below a minimum value.
        let newRadius = max(radius + distanceDelta, 0.01)

        // Convert spherical coordinates to Cartesian coordinates.
        let newX = newRadius * sin(newYaw) * cos(newPitch)
        let newY = newRadius * sin(newPitch)
        let newZ = newRadius * cos(newYaw) * cos(newPitch)

        // Update the camera's position and the center point.
        self.eye = lookAt + f3(newX, newY, newZ)
        self.lookAt = lookAt

        updateViewMatrix()
    }
}

fileprivate extension Float {
    /// Converts an angle in degrees to radians.
    ///
    /// - Parameter deg: The angle in degrees.
    /// - Returns: The angle in radians.
    static func degreesToRadians(_ deg: Float) -> Self {
        return Self(deg / 360 * Float.pi * 2)
    }
}
