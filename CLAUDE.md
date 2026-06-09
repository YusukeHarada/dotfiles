# CLAUDE.md

macOS 向け個人 dotfiles リポジトリ。`main` ブランチのみで管理する。

## リポジトリ構成

```
dotfiles/
├── .claude/settings.json          # Claude Code 設定（テーマなど）
├── .config/
│   ├── gh/config.yml              # GitHub CLI 設定
│   └── karabiner/karabiner.json   # Karabiner-Elements キーボード設定
├── .gitconfig                     # Git ユーザー情報・エイリアス
├── .gitflow_export                # git-flow 設定
├── .gitignore                     # このリポジトリ自体の除外ルール
├── .gitignore_global              # 全リポジトリ共通の Git 除外ルール
├── .hgignore_global               # Mercurial 除外ルール
├── .stCommitMsg                   # コミットテンプレート（Conventional Commits）
├── .vimrc                         # Vim 設定
├── .zprofile                      # ログインシェル設定（Homebrew PATH）
├── .zshrc                         # zsh メイン設定
├── Brewfile                       # Homebrew パッケージ一覧
├── install.sh                     # セットアップスクリプト
├── vscode/settings.json           # VS Code ユーザー設定
└── README.md
```

## セットアップの仕組み

`install.sh` を実行すると `~/dotfiles/` 内の実体ファイルへのシンボリックリンクをホームディレクトリに張る。既存ファイルは `~/.dotfiles_backup/<timestamp>/` に退避される。

```bash
bash install.sh
```

リンク先のパス：
- 通常ファイル: `~/dotfiles/<file>` → `~/<file>`
- VS Code 設定: `~/dotfiles/vscode/settings.json` → `~/Library/Application Support/Code/User/settings.json`
- Claude Code 設定: `~/dotfiles/.claude/settings.json` → `~/.claude/settings.json`

## Brewfile の運用

パッケージを追加・削除したら都度 `brew bundle dump` で再生成してコミットする。

```bash
brew bundle dump --file=~/dotfiles/Brewfile --force
```

構成：
- `brew`: CLI ツール（bat, eza, fd, fzf, ripgrep, zoxide など）
- `cask`: GUI アプリ（VS Code, Claude Code, Hack Nerd Font など）
- `vscode`: VS Code 拡張機能

## .zshrc の主な構成

| セクション | 内容 |
|---|---|
| pyenv | Python バージョン管理 |
| ARM GCC | 組み込み開発用ツールチェーン（`/Applications/ArmGNUToolchain/`） |
| 補完 | compinit（24時間キャッシュ） |
| プロンプト | vcs_info による Git ブランチ表示 |
| zsh plugins | zsh-autosuggestions / zsh-syntax-highlighting（Homebrew 経由） |
| fzf | キーバインド + fd をデフォルトコマンドに設定 |
| zoxide | `z` コマンドによるスマートジャンプ |
| エイリアス | ls→eza, cat→bat, grep→rg, find→fd + git shortcuts |

## コミット規約

Conventional Commits 形式（`.stCommitMsg` テンプレート）を使用する。

```
<type>(<scope>): <subject>
```

| type | 用途 |
|---|---|
| `feat` | 新機能 |
| `fix` | バグ修正 |
| `docs` | ドキュメントのみの変更 |
| `chore` | ビルド・ツール類の変更 |
| `refactor` | リファクタリング |
| `style` | フォーマットのみの変更 |
| `perf` | パフォーマンス改善 |
| `revert` | 取り消し |

## 開発上の注意

- **ブランチは `main` のみ**。OS 別管理は別リポジトリで行う。
- `install.sh` を変更する際は `link` 関数の引数にリポジトリ内の相対パスを渡す形式を維持する。
- `Brewfile` に `cask` を追加する場合、フォント系は `font-` プレフィックスが必要（例: `font-hack-nerd-font`）。
- `.zshrc` のプラグイン読み込みは `/opt/homebrew/` パスを前提としている（Apple Silicon Mac）。Intel Mac では `/usr/local/` に変わる点に注意。
