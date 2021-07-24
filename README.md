# dotfiles

1. install
- git
- python3
- neovim
- zsh
- rg
- fd
- bat
- fortls

2. run
```sh
./install.sh host
```

3. vim manual setup
- :CocConfig

```json
"languageserver": {
  "fortran": {
    "command": "fortls",
    "filetypes": ["fortran"],
    "rootPatterns": [".fortls", ".git/"]
  }
}
```
