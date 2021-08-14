import ProjectDescription

public enum ModuleType: String {
    case service = "Services"
    case feature = "Features"
    case helper = "Helpers"
}

extension Project {
    /// Helper function to create API projects for modules
    public static func api(name: String, dependencies: [TargetDependency]) -> Project {
        let targets = makeFrameworkTargets(name: name, isResourcesNeeded: false, dependencies: dependencies, isTestTargetNeeded: false)
        let schemes = makeProjectSchemes(name: name, isSampleSchemeNeeded: false)

        return Project(name: name, organizationName: "scalablemonorepo.com", targets: targets, schemes: schemes)
    }

    /// Helper function to create module projects for modules
    public static func module(name: String, type: ModuleType, dependencies: [TargetDependency], isResourcesNeeded: Bool = true) -> Project {
        var targets = makeSampleTarget(
            name: name, 
            dependencies: generateSampleDependencies(name: name, type: type)
        )
        targets += makeFrameworkTargets(name: name, isResourcesNeeded: isResourcesNeeded, dependencies: dependencies)
        
        let schemes = makeProjectSchemes(name: name)

        return Project(name: name, organizationName: "scalablemonorepo.com", targets: targets, schemes: schemes)
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String, isResourcesNeeded: Bool, dependencies: [TargetDependency], isTestTargetNeeded: Bool = true) -> [Target] {
        let main = Target(
            name: name,
            platform: .iOS,
            product: .staticFramework,
            bundleId: "com.scalablemonorepo.\(name)",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: .default,
            sources: ["\(name)/Sources/**"],
            resources: isResourcesNeeded ? ["\(name)/Resources/**"] : [],
            dependencies: dependencies,
            settings: Settings(
                configurations: [
                    .debug(name: "Debug", settings: [:], xcconfig: nil),
                    .release(name: "Release", settings: [:], xcconfig: nil)
                ]
            )
        )

        let test = Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.scalablemonorepo.\(name)Tests",
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            resources: ["\(name)Tests/Resources/**"],
            dependencies: [
                .target(name: "\(name)")
            ]
        )
        
        return isTestTargetNeeded ? [main, test] : [main]
    }

    /// Helper function to create a sample framework target
    private static func makeSampleTarget(name: String, dependencies: [TargetDependency]) -> [Target] {
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
        ]

        let target = Target(
            name: "\(name)Sample",
            platform: .iOS,
            product: .app,
            bundleId: "com.scalablemonorepo.\(name)Sample",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(name)Sample/Sources/**"],
            resources: ["\(name)Sample/Resources/**"],
            dependencies: dependencies,
            settings: Settings(
                configurations: [
                    .debug(name: "Debug", settings: [:], xcconfig: nil),
                    .release(name: "Release", settings: [:], xcconfig: nil)
                ]
            )
        )

        return [target]
    }

    /// Helper function to create a sample framework scheme and a framework scheme
    private static func makeProjectSchemes(name: String, isSampleSchemeNeeded: Bool = true) -> [Scheme] {
        let sample = Scheme(
            name: "\(name)Sample",
            shared: true,
            buildAction: BuildAction(
                targets: ["\(name)Sample"],
                preActions: []
            ),
            testAction: TestAction(
                targets: [TestableTarget(target: "\(name)Tests")]
            ),
            runAction: RunAction(
                configurationName: "Debug",
                executable: "\(name)Sample"
            )
        )

        let framework = Scheme(
            name: name,
            shared: true,
            buildAction: BuildAction(
                targets: ["\(name)"],
                preActions: []
            ),
            testAction: TestAction(
                targets: [TestableTarget(target: "\(name)Tests")]
            )
        )

        return isSampleSchemeNeeded ? [sample, framework] : [framework]
    }

    private static func generateSampleDependencies(name: String, type: ModuleType) -> [TargetDependency] {
        var sampleGenericDependencies: [TargetDependency] = [
            .project(target: "DIServiceAPI", path: "../../Services/DIServiceAPI"),
            .project(target: "DIService", path: "../../Services/DIService"),
            .project(target: "NetworkServiceAPI", path: "../../Services/NetworkServiceAPI"),
            .project(target: "NetworkService", path: "../../Services/NetworkService"),
            .project(target: "UIHelper", path: "../../Helpers/UIHelper")
        ]
        
        let sampleDependency: TargetDependency = TargetDependency.project(target: "\(name)", path: "../../\(type.rawValue)/\(name)")
        
        if !sampleGenericDependencies.contains(where: { $0 == sampleDependency }) {
            sampleGenericDependencies.append(sampleDependency)
        }

        return sampleGenericDependencies
    }
}
