# dotfiles

個人の設定ファイル（dotfiles）を一元管理するリポジトリです。

---

## 管理しているファイル

| ファイル | 用途 |
|---|---|
| `.zshrc` | zsh の設定（エイリアス、補完、プロンプト、プラグインなど） |
| `.zprofile` | ログインシェル用の設定（Homebrew PATH など） |
| `.gitconfig` | Git のユーザー情報・エイリアス・delta 設定 |
| `.gitignore_global` | 全リポジトリ共通の Git 除外ルール |
| `.stCommitMsg` | Git コミットテンプレート（Conventional Commits 形式） |
| `.vimrc` | Vim の設定 |
| `.config/gh/config.yml` | GitHub CLI の設定 |
| `.config/karabiner/karabiner.json` | Karabiner-Elements のキーボード設定 |
| `.config/bat/config` | bat（cat 代替）のテーマ・表示設定 |
| `Brewfile` | Homebrew でインストールするパッケージ一覧 |
| `vscode/settings.json` | VS Code のユーザー設定 |
| `.claude/settings.json` | Claude Code の設定（テーマ・パーミッションなど） |

---

## 仕組み

`~/dotfiles/` に実体ファイルを置き、ホームディレクトリからシンボリックリンクで参照します。

```
~/.zshrc      →  ~/dotfiles/.zshrc（実体）
~/.gitconfig  →  ~/dotfiles/.gitconfig（実体）
...
```

こうすることで、設定ファイルの変更を git で追跡・バックアップできます。

---

## 新しい Mac にセットアップする手順

```bash
# 1. リポジトリをクローン
git clone https://github.com/YusukeHarada/dotfiles ~/dotfiles

# 2. シンボリックリンクを張る（既存ファイルは自動でバックアップされます）
bash ~/dotfiles/install.sh

# 3. Homebrew パッケージを一括インストール（ツール＋フォントも含む）
brew bundle --file=~/dotfiles/Brewfile

# 4. ターミナルのフォントを変更
#    iTerm2:       Preferences → Profiles → Text → Font → "Hack Nerd Font"
#    Terminal.app: 環境設定 → プロファイル → テキスト → フォントを変更

# 5. 設定を即時反映（または新しいターミナルを開く）
source ~/.zshrc
```

> **注意:** `install.sh` は既存ファイルを上書きせず、`~/.dotfiles_backup/` に退避してからリンクを張ります。

---

## install.sh でできること

`bash ~/dotfiles/install.sh` を実行すると、以下のシンボリックリンクが自動で作成されます。

### シェル設定

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.zshrc` | `dotfiles/.zshrc` | エイリアス・補完・プロンプト・プラグイン |
| `~/.zprofile` | `dotfiles/.zprofile` | Homebrew の PATH 設定（ログインシェル） |

### Git 設定

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.gitconfig` | `dotfiles/.gitconfig` | ユーザー情報・エイリアス・delta による diff 表示 |
| `~/.gitignore_global` | `dotfiles/.gitignore_global` | 全リポジトリ共通の除外ルール |
| `~/.stCommitMsg` | `dotfiles/.stCommitMsg` | Conventional Commits 形式のコミットテンプレート |

### ツール設定

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.config/gh/` | `dotfiles/.config/gh/` | GitHub CLI の設定 |
| `~/.config/karabiner/` | `dotfiles/.config/karabiner/` | Karabiner-Elements のキーボード設定 |
| `~/.config/bat/` | `dotfiles/.config/bat/` | bat のテーマ（GitHub）・行番号・変更行表示 |

### エディタ設定

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.vimrc` | `dotfiles/.vimrc` | Vim の設定 |
| `~/Library/Application Support/Code/User/settings.json` | `dotfiles/vscode/settings.json` | VS Code のユーザー設定 |

### Claude Code 設定

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.claude/settings.json` | `dotfiles/.claude/settings.json` | テーマ・パーミッションなど |

> 既存ファイルがある場合は `~/.dotfiles_backup/<timestamp>/` に自動でバックアップされます。

---

## 主なシェル機能

### キーボードショートカット

| ショートカット | 動作 |
|---|---|
| `Ctrl+R` | コマンド履歴をインタラクティブに検索（fzf） |
| `Ctrl+T` | カレントディレクトリ以下のファイルを検索（fzf）、bat でプレビュー表示 |
| `Tab` | 補完候補をメニュー表示 |

### エイリアス一覧

**ファイル操作**

| エイリアス | 展開 | 説明 |
|---|---|---|
| `ls` | `eza --icons` | アイコン付きファイル一覧 |
| `ll` | `eza -laF --icons --git` | 詳細表示＋Git 差分ステータス |
| `la` | `eza -aF --icons` | 隠しファイルも表示 |
| `lt` | `eza --tree --icons` | ツリー表示 |
| `cat` | `bat --paging=never` | シンタックスハイライト付き表示 |
| `grep` | `rg --color=auto` | 高速 grep（ripgrep） |
| `find` | `fd` | 使いやすい find 代替 |

**ディレクトリ移動**

| エイリアス | 説明 |
|---|---|
| `..` | 1階層上へ |
| `...` | 2階層上へ |
| `z <name>` | よく訪れるディレクトリへスマートジャンプ（zoxide） |

**Git**

| エイリアス | 展開 | 説明 |
|---|---|---|
| `gs` | `git status` | |
| `ga` | `git add` | |
| `gc` | `git commit` | |
| `gcm` | `git commit -m` | |
| `gp` | `git push` | |
| `gl` | `git pull` | |
| `gd` | `git diff` | delta によるシンタックスハイライト表示 |
| `gb` | `git branch` | |
| `gco` | `git checkout` | |
| `glog` | `git log --oneline --graph --decorate --all` | |
| `gst` | `git stash` | |
| `gstp` | `git stash pop` | |

### Git エイリアス（.gitconfig）

| エイリアス | 展開 | 説明 |
|---|---|---|
| `git recent` | `git log --oneline -10` | 直近10件のコミットを表示 |
| `git staged` | `git diff --cached` | ステージ済みの差分を表示 |
| `git cleanup` | `git branch --merged \| grep -v main \| xargs git branch -d` | マージ済みブランチを一括削除 |
| `git undo` | `git reset HEAD~1 --mixed` | 直前のコミットを取り消し（変更は保持） |
| `git unstage` | `git reset HEAD --` | ステージを取り消し |
| `git lg` | `git log --oneline --graph --decorate --all` | グラフ付きログ |

---

## Conventional Commits テンプレート

`git commit` を実行するとエディタに以下のテンプレートが表示されます。

```
# <type>(<scope>): <subject>
```

| type | 用途 |
|---|---|
| `feat` | 新機能 |
| `fix` | バグ修正 |
| `docs` | ドキュメントのみの変更 |
| `style` | コードの意味に影響しない変更（空白・フォーマット等） |
| `refactor` | バグ修正でも機能追加でもないコード変更 |
| `test` | テストの追加・修正 |
| `chore` | ビルドプロセスや補助ツールの変更 |
| `perf` | パフォーマンス改善 |
| `revert` | コミットの取り消し |

---

## 日常の使い方

### 設定を変更したいとき

```bash
# dotfiles 内のファイルを直接編集する（~/dotfiles/ 配下）
vim ~/dotfiles/.zshrc

# 変更を反映
source ~/.zshrc

# GitHub に保存
cd ~/dotfiles
git add .zshrc
git commit -m "zshrc: ○○を追加"
git push
```

> `~/.zshrc` はシンボリックリンクなので、`~/.zshrc` を直接編集しても同じです。

---

### Brewfile を更新したいとき

パッケージを追加・削除したら Brewfile を再生成して保存します。

```bash
brew bundle dump --file=~/dotfiles/Brewfile --force

cd ~/dotfiles
git add Brewfile
git commit -m "chore: ○○を追加"
git push
```

---

### 新しい設定ファイルを管理対象に追加したいとき

```bash
# 1. dotfiles にコピー
cp ~/.newconfig ~/dotfiles/.newconfig

# 2. 元のファイルをシンボリックリンクに置き換え
ln -sfn ~/dotfiles/.newconfig ~/.newconfig

# 3. install.sh にも追記（次のセットアップのため）
vim ~/dotfiles/install.sh
# → link .newconfig  を追加

# 4. コミット
cd ~/dotfiles
git add .
git commit -m "chore: .newconfig を管理対象に追加"
git push
```

---

## ディレクトリ構成

```
~/dotfiles/
├── .claude/
│   └── settings.json            # Claude Code の設定
├── .config/
│   ├── bat/
│   │   └── config               # bat 設定（テーマ・表示スタイル）
│   ├── gh/
│   │   └── config.yml           # GitHub CLI 設定
│   └── karabiner/
│       └── karabiner.json       # Karabiner 設定
├── .gitconfig
├── .gitignore                   # dotfiles リポジトリ自体の除外ルール
├── .gitignore_global            # 全 Git リポジトリ共通の除外ルール
├── .gitflow_export
├── .hgignore_global
├── .stCommitMsg                 # コミットテンプレート（Conventional Commits）
├── .vimrc
├── .zprofile
├── .zshrc
├── vscode/
│   └── settings.json            # VS Code ユーザー設定
├── Brewfile                     # Homebrew パッケージ一覧
├── install.sh                   # セットアップスクリプト
└── README.md                    # このファイル
```
