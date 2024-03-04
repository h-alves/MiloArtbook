// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Milo’s Artbook",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Milo’s Artbook",
            targets: ["AppModule"],
            bundleIdentifier: "com.haskz.WWDC24",
            teamIdentifier: "225S533H7W",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.yellow),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .copy("Resources/HandDrawingClassifier.mlmodelc")
            ]
        )
    ]
)