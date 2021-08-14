# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# SwiftLint configuration
`sed -i '' 's/#- todo/- todo/g' .swiftlint.yml`
swiftlint.config_file = '.swiftlint.yml'

# Set fail if a warning is found
swiftlint.strict = false 

# Run linter to show summary
swiftlint.lint_files(fail_on_error: true)

# Run linter to add comments inline
swiftlint.lint_files(inline_mode: true, fail_on_error: true)