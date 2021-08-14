import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../../Services/DIServiceAPI"),
    .project(target: "NetworkServiceAPI", path: "../../Services/NetworkServiceAPI"),
]

let project = Project.module(name: "HomeFeature", type: .feature, dependencies: dependencies)