import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let dependencies: [TargetDependency] = [
    // MARK: DO NOT ERASE THIS LINE! Dependencies
    .project(target: "UIHelper", path: "../Modules/Helpers/UIHelper"),
    .project(target: "DIServiceAPI", path: "../Modules/Services/DIServiceAPI"),
    .project(target: "DIService", path: "../Modules/Services/DIService"),
    .project(target: "NetworkServiceAPI", path: "../Modules/Services/NetworkServiceAPI"),
    .project(target: "NetworkService", path: "../Modules/Services/NetworkService"),
    .project(target: "LoginFeatureAPI", path: "../Modules/Features/LoginFeatureAPI"),
    .project(target: "LoginFeature", path: "../Modules/Features/LoginFeature"),
    .project(target: "HomeFeatureAPI", path: "../Modules/Features/HomeFeatureAPI"),
    .project(target: "HomeFeature", path: "../Modules/Features/HomeFeature")
]

let project = Project(
    name: "ScalableMonorepo", 
    organizationName: "scalablemonorepo.com", 
    targets: [
        Target(
            name: "ScalableMonorepo",
            platform: .iOS,
            product: .app,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: "ScalableMonorepo/Sources/Supporting Files/Info.plist",
            sources: ["ScalableMonorepo/Sources/**"],
            resources: ["ScalableMonorepo/Resources/**"],
            dependencies: dependencies,
            settings: Settings(
                configurations: [
                    .debug(name: "Debug", settings: [:], xcconfig: "XCConfig/ScalableMonorepoDebug.xcconfig"),
                    .release(name: "Release", settings: [:], xcconfig: "XCConfig/ScalableMonorepoRelease.xcconfig")
                ]
            )
        ),
        Target(
            name: "ScalableMonorepoTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
            infoPlist: "ScalableMonorepoTests/Info.plist",
            sources: ["ScalableMonorepoTests/Sources/**"],
            dependencies: [
                .target(name: "ScalableMonorepo")
            ],
            settings: Settings(
                configurations: [
                    .debug(name: "Debug", settings: [:], xcconfig: "XCConfig/ScalableMonorepoTestsDebug.xcconfig"),
                    .release(name: "Release", settings: [:], xcconfig: "XCConfig/ScalableMonorepoTestsRelease.xcconfig")
                ]
            )
        )
    ],
    schemes: [
        Scheme(
            name: "Scalable Monorepo - Debug",
            shared: true,
            buildAction: BuildAction(
                targets: ["ScalableMonorepo"],
                preActions: []
            ),
            testAction: TestAction(
                targets: [TestableTarget(target: "ScalableMonorepoTests")]
            ),
            runAction: RunAction(
                configurationName: "Debug",
                executable: "ScalableMonorepo"
            ),
            archiveAction: ArchiveAction(
                configurationName: "Debug",
                customArchiveName: "Scalable Monorepo - Debug"
            )
        ),
        Scheme(
            name: "Scalable Monorepo - Release",
            shared: true,
            buildAction: BuildAction(
                targets: ["ScalableMonorepo"],
                preActions: []
            ),
            testAction: TestAction(
                targets: [TestableTarget(target: "ScalableMonorepoTests")]
            ),
            runAction: RunAction(
                configurationName: "Release",
                executable: "ScalableMonorepo"
            ),
            archiveAction: ArchiveAction(
                configurationName: "Release",
                customArchiveName: "Scalable Monorepo - Release"
            )
        )
    ]
)
