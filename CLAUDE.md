# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A gem that ships an opinionated, shareable RuboCop configuration. The product is the YAML files at the repo root, not Ruby code: `lib/` contains only the version constant and an empty module.

## Commands

- `bin/setup`: runs `bundle install`
- `bundle exec rake`: the default task, which runs `spec` and then `rubocop`. CI runs this on Ruby 3.2.0 (`.github/workflows/main.yml`).
- `bundle exec rubocop`: lints the repo with its own config (`.rubocop.yml`). Pass a path to lint a single file.
- `bundle exec rake spec`: there is no `spec/` directory yet, so this runs zero examples.
- `bin/rubocop_fonsan_style [args]`: runs RuboCop through `bundler/inline`, using only the gemspec's runtime dependencies. Use it to try the cops against another project without editing that project's Gemfile.
- Release: bump `VERSION` in `lib/rubocop_fonsan_style/version.rb`, run `bundle install` so `Gemfile.lock` picks up the new version, then run `bundle exec rake release`. Built `*.gem` files are gitignored.

## Config layout

The configs build on each other through `inherit_from`:

- `.rubocop.default.yml`: the core Ruby style. Requires `rubocop-performance` and `rubocop-rubycw` and sets `TargetRubyVersion: 3.0.0`.
- `.rubocop.rails.yml`: requires `rubocop-rails`.
- `.rubocop.rspec.yml`: requires `rubocop-rspec`.
- `.rubocop.all.yml`: inherits the three files above.
- `.rubocop.yml`: this repo's own config, which inherits `.rubocop.all.yml`.

Consuming projects pick one of these files with `inherit_gem` (for example `inherit_gem: { rubocop_fonsan_style: .rubocop.all.yml }`). File names and paths are therefore a public interface, so don't rename or move them.

## Conventions when editing configs

- When enabling a cop that RuboCop marks as pending, add an inline comment with the version that introduced it, e.g. `Style/SuperArguments: # new in 1.64`. New cops usually go near the top of their section.
- Cop and plugin versions are tied to the version constraints in the gemspec (`rubocop ~> 1.68`, `rubocop-rails ~> 2.27`, `rubocop-rspec ~> 3.2`, `rubocop-performance ~> 1.22`). A cop that only exists in a newer release needs a gemspec bump first. Keep runtime dependencies in the gemspec; the Gemfile only holds test/dev gems.
- `haml_lint` is a runtime dependency, but this repo has no haml-lint config.
- Main style choices to stay consistent with: fixed indentation instead of alignment (arguments, arrays, parameters, multiline calls), trailing `.` for method chains, `end` aligned with the variable, no spaces inside hash braces or before block params (`{|x| ... }`), line length 200, method length 15, `Style/FrozenStringLiteralComment` disabled, and `Metrics/AbcSize`, `ClassLength` and `ModuleLength` disabled.
