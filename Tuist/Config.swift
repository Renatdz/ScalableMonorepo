import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["12.5.1"],
    swiftVersion: "5.4.0",
    generationOptions: [
        .organizationName("Scalable Monorepo"),
        .disableAutogeneratedSchemes
    ]
)
