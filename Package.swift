// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "ClinkerResult",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(name: "App")
    ],
    swiftLanguageVersions: [.v5]
)
