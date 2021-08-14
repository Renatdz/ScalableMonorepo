import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    .project(target: "DIServiceAPI", path: "../DIServiceAPI")
]

let project = Project.module(name: "DIService", type: .service, dependencies: dependencies, isResourcesNeeded: false)