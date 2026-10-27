## [Unreleased]

## [0.2.0] - 2026-10-27

- Require Ruby >= 3.4; CI on Ruby 3.4 and 4.0
- Stop setting `TargetRubyVersion` in the shared config so RuboCop infers it from each project (`.ruby-version`, Gemfile.lock, gemspec)
- Bump rubocop to 1.92, rubocop-performance 1.27, rubocop-rails 2.38, rubocop-rspec 3.10, rubocop-rubycw 0.2, haml_lint 0.78
- Load extensions via `plugins:` instead of `require:`
- Remove obsolete `RSpec/StringAsInstanceDoubleConstant` (use `RSpec/VerifiedDoubleReference`)
- Enable `AllCops/UseProjectIndex` and depend on `rubydex` for cross-file cops (ArgumentMismatch, SuperArgumentMismatch, NameTypo, DeprecatedReference)
- Configure all 64 new cops; disabled: `Layout/EmptyLinesAfterModuleInclusion`, `Style/OneClassPerFile`, `Rails/FindByOrAssignmentMemoization`

## [0.1.0] - 2022-11-26

- Initial release
