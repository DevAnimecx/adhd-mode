# Contributing to adhd-mode

## Adding a new tool

1. Open an issue using the [new-tool template](.github/ISSUE_TEMPLATE/new-tool.md).
2. Add a render function in `scripts/build.py` for the new tool's format.
3. Add the file path to `FILES` and `PARITY_FILES` in `scripts/check_parity.py`.
4. Add the tool to the installer (`install/install.sh` and `install/install.ps1`).
5. Add the tool to the README's supported-tools table.
6. Run `python scripts/build.py && python scripts/check_parity.py`.
7. Test in the actual tool with the 6 canonical prompts.
8. Submit a PR.

## Editing the rules

1. Edit `CORE` in `scripts/build.py` — the single source of truth.
2. Run `python scripts/build.py` to re-render all files.
3. Bump `VERSION` if the rules changed substantively.
4. Run `python scripts/check_parity.py`.
5. Submit a PR.

## Testing

Before submitting a PR for a new tool, test in the actual tool:
- Fresh repo with only the rule file
- Run the 6 canonical prompts from [docs/IMPLEMENTATION.md](docs/IMPLEMENTATION.md)
- Record results in `tests/results.md`

## License

By contributing, you agree your contributions are licensed under MIT.
