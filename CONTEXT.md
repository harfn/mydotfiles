# Context

## Glossary

### Base Config
A minimal, portable Neovim configuration intended to run on machines where the user's dotfiles are intentionally installed, including servers, containers, and terminal-focused systems. It may assume a small shared CLI toolkit such as `fzf`, but should avoid heavyweight IDE features and machine-specific integrations.

The Base Config includes syntax highlighting for code editing, but excludes IDE-style code intelligence such as language servers, completion, formatting orchestration, and debugging.

### Nvim IDE Config
An extended Neovim configuration layered on top of the Base Config for environments where IDE-like behavior is desired. It may add language servers, completion, formatting, debugging, and richer UI integrations.

### Base Theme
The Base Config uses exactly one stable default theme: `ayu_dark`.

### IDE Theme Extensions
The `nvim_ide` profile may add additional theme variants, including `gruvbox` light and dark, and any theme switching logic associated with them.
