import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../../Services/DIServiceAPI")
]

let project = Project.api(name: "HomeFeatureAPI", dependencies: dependencies)