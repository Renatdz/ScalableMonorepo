import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "ScalableMonorepo",
    projects: [
        "ScalableMonorepo",
        "Modules/Features/**",
        "Modules/Helpers/**",
        "Modules/Services/**"
    ]
)