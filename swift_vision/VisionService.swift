/**
 * 📸 macOS/iOS CV module using Vision + SwiftUI
 * Computer vision service for image processing
 */

import Foundation
import Vision
import SwiftUI

@available(macOS 11.0, iOS 14.0, *)
public class VisionService {
    
    public init() {}
    
    /// Process an image using Vision framework
    /// - Parameter imageURL: URL to the image file
    /// - Returns: Array of detected objects/features
    public func processImage(at imageURL: URL) async throws -> [VisionResult] {
        guard let imageData = try? Data(contentsOf: imageURL),
              let image = UIImage(data: imageData) else {
            throw VisionError.invalidImage
        }
        
        return try await detectObjects(in: image)
    }
    
    /// Detect objects in an image
    private func detectObjects(in image: UIImage) async throws -> [VisionResult] {
        guard let cgImage = image.cgImage else {
            throw VisionError.invalidImage
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeObjectsRequest { request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let observations = request.results as? [VNRecognizedObjectObservation] else {
                    continuation.resume(returning: [])
                    return
                }
                
                let results = observations.map { observation -> VisionResult in
                    let labels = observation.labels.map { label in
                        Label(identifier: label.identifier, confidence: Double(label.confidence))
                    }
                    return VisionResult(
                        boundingBox: observation.boundingBox,
                        labels: labels,
                        confidence: Double(observation.confidence)
                    )
                }
                
                continuation.resume(returning: results)
            }
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}

// MARK: - Supporting Types

public struct VisionResult {
    public let boundingBox: CGRect
    public let labels: [Label]
    public let confidence: Double
    
    public init(boundingBox: CGRect, labels: [Label], confidence: Double) {
        self.boundingBox = boundingBox
        self.labels = labels
        self.confidence = confidence
    }
}

public struct Label {
    public let identifier: String
    public let confidence: Double
    
    public init(identifier: String, confidence: Double) {
        self.identifier = identifier
        self.confidence = confidence
    }
}

public enum VisionError: Error {
    case invalidImage
    case processingFailed
}

// MARK: - SwiftUI View

@available(macOS 11.0, iOS 14.0, *)
public struct VisionServiceView: View {
    @State private var results: [VisionResult] = []
    @State private var isProcessing = false
    
    public init() {}
    
    public var body: some View {
        VStack {
            if isProcessing {
                ProgressView("Processing image...")
            } else {
                List(results, id: \.boundingBox) { result in
                    VStack(alignment: .leading) {
                        Text("Confidence: \(result.confidence, specifier: "%.2f")")
                        ForEach(result.labels, id: \.identifier) { label in
                            Text("\(label.identifier): \(label.confidence, specifier: "%.2f")")
                        }
                    }
                }
            }
        }
        .padding()
    }
}

