import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project
let dependencies: [TargetDependency] = []

let project = Project.module(name: "UIHelper", type: .helper, dependencies: dependencies)