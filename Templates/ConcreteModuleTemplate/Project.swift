import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = [
    DependencyAPI
]

let project = Project.module(name: "<module_name>", type: <module_type>, dependencies: dependencies)