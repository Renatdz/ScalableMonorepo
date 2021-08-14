import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../DIServiceAPI"),
    .project(target: "NetworkServiceAPI", path: "../NetworkServiceAPI")
]

let project = Project.module(name: "NetworkService", type: .service, dependencies: dependencies)