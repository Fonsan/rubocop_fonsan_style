# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A gem that ships an opinionated, shareable RuboCop configuration. The product is the YAML files at the repo root, not Ruby code: `lib/` contains only the version constant and an empty module.

## Commands

- `bin/setup`: runs `bundle install`
- `bundle exec rake`: the default task, which runs `spec` and then `rubocop`. CI runs this on Ruby 3.4 and 4.0 (`.github/workflows/main.yml`).
- `bundle exec rubocop`: lints the repo with its own config (`.rubocop.yml`). Pass a path to lint a single file.
- `bundle exec rake spec`: `spec/rubocop_fonsan_style_spec.rb` loads each shipped config and fails on removed, renamed or unknown cops and on any cop still `pending`. After a gem bump, this is how missing decisions show up.
- `bin/rubocop_fonsan_style [args]`: runs RuboCop through `bundler/inline`, using only the gemspec's runtime dependencies. Use it to try the cops against another project without editing that project's Gemfile.
- Release: bump `VERSION` in `lib/rubocop_fonsan_style/version.rb`, run `bundle install` so `Gemfile.lock` picks up the new version, then run `bundle exec rake release`. Built `*.gem` files are gitignored.

## Config layout

The configs build on each other through `inherit_from`:

- `.rubocop.default.yml`: the core Ruby style. Loads `rubocop-performance` and `rubocop-rubycw` via `plugins:` and enables `AllCops/UseProjectIndex` (backed by the `rubydex` runtime dependency). It deliberately sets no `TargetRubyVersion`, so RuboCop infers it from each consuming project.
- `.rubocop.rails.yml`: loads `rubocop-rails` via `plugins:`.
- `.rubocop.rspec.yml`: loads `rubocop-rspec` via `plugins:`.
- `.rubocop.all.yml`: inherits the three files above.
- `.rubocop.yml`: this repo's own config, which inherits `.rubocop.all.yml` and pins `TargetRubyVersion: 3.4` to match the gemspec floor.

Consuming projects pick one of these files with `inherit_gem` (for example `inherit_gem: { rubocop_fonsan_style: .rubocop.all.yml }`). File names and paths are therefore a public interface, so don't rename or move them.

## Conventions when editing configs

- When enabling a cop that RuboCop marks as pending, add an inline comment with the version that introduced it, e.g. `Style/SuperArguments: # new in 1.64`. Each upgrade appends its batch of new cops at the end of the relevant file. Every pending cop gets an explicit `Enabled: true` or `Enabled: false`; never use `AllCops/NewCops`.
- Cop and plugin versions are tied to the version constraints in the gemspec (`rubocop ~> 1.92`, `rubocop-rails ~> 2.38`, `rubocop-rspec ~> 3.10`, `rubocop-performance ~> 1.27`, `rubocop-rubycw ~> 0.2`). A cop that only exists in a newer release needs a gemspec bump first. Keep runtime dependencies in the gemspec; the Gemfile only holds test/dev gems.
- Plugins go under `plugins:`, not `require:` (deprecated since rubocop 1.72).
- `haml_lint` is a runtime dependency, but this repo has no haml-lint config.
- Main style choices to stay consistent with: fixed indentation instead of alignment (arguments, arrays, parameters, multiline calls), trailing `.` for method chains, `end` aligned with the variable, no spaces inside hash braces or before block params (`{|x| ... }`), line length 200, method length 15, `Style/FrozenStringLiteralComment` disabled, and `Metrics/AbcSize`, `ClassLength` and `ModuleLength` disabled.
