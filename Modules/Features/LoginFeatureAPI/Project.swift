import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../../Services/DIServiceAPI")
]

let project = Project.api(name: "LoginFeatureAPI", dependencies: dependencies)