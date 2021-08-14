import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../DIServiceAPI")
]

let project = Project.api(name: "NetworkServiceAPI", dependencies: dependencies)