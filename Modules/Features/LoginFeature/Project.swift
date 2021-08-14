import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../../Services/DIServiceAPI"),
    .project(target: "NetworkServiceAPI", path: "../../Services/NetworkServiceAPI"),
    .project(target: "LoginFeatureAPI", path: "../LoginFeatureAPI"),
    .project(target: "HomeFeatureAPI", path: "../HomeFeatureAPI"),
    .project(target: "UIHelper", path: "../../Helpers/UIHelper")
]

let project = Project.module(name: "LoginFeature", type: .feature, dependencies: dependencies)