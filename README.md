# dotfiles

個人の設定ファイル（dotfiles）を一元管理するリポジトリです。

> **dotfiles とは？**
> ターミナルや Git などの開発ツールの設定ファイルのことです。ファイル名が `.`（ドット）で始まることから「dotfiles」と呼ばれます。このリポジトリで一元管理することで、Mac を買い替えたときも同じ環境をすぐに再現できます。

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

> **シンボリックリンクとは？**
> ファイルの「ショートカット」のようなものです。`~/.zshrc` を開いても `~/dotfiles/.zshrc` を開いても同じファイルを編集していることになります。dotfiles 側で編集すれば git で変更を追跡・バックアップできます。

---

## 新しい Mac にセットアップする手順

> **前提条件:** Homebrew がインストール済みであること。未インストールの場合は [brew.sh](https://brew.sh) の手順に従ってインストールしてください。

```bash
# 1. リポジトリをクローン（dotfiles フォルダとしてダウンロード）
git clone https://github.com/YusukeHarada/dotfiles ~/dotfiles

# 2. シンボリックリンクを張る（既存ファイルは自動でバックアップされます）
bash ~/dotfiles/install.sh

# 3. Homebrew パッケージを一括インストール（ツール＋フォントも含む）
brew bundle --file=~/dotfiles/Brewfile

# 4. ターミナルのフォントを変更（アイコンを正しく表示するために必要）
#    iTerm2:       Preferences → Profiles → Text → Font → "Hack Nerd Font"
#    Terminal.app: 環境設定 → プロファイル → テキスト → フォントを変更

# 5. 設定を即時反映（または新しいターミナルを開く）
source ~/.zshrc
```

> **注意:** `install.sh` は既存ファイルを上書きせず、`~/.dotfiles_backup/` に退避してからリンクを張ります。万が一元に戻したい場合はそちらを参照してください。

---

## install.sh でできること

`bash ~/dotfiles/install.sh` を実行すると、以下のシンボリックリンクが自動で作成されます。コマンド1つで開発環境全体の設定が完了します。

### シェル設定

ターミナル（zsh）の動作を設定します。

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.zshrc` | `dotfiles/.zshrc` | エイリアス・補完・プロンプト・プラグイン |
| `~/.zprofile` | `dotfiles/.zprofile` | Homebrew の PATH 設定（ログインシェル） |

### Git 設定

Git の動作・表示をカスタマイズします。

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.gitconfig` | `dotfiles/.gitconfig` | ユーザー情報・エイリアス・delta による diff 表示 |
| `~/.gitignore_global` | `dotfiles/.gitignore_global` | 全リポジトリ共通の除外ルール（`.DS_Store` など） |
| `~/.stCommitMsg` | `dotfiles/.stCommitMsg` | Conventional Commits 形式のコミットテンプレート |

### ツール設定

各種 CLI ツールの設定をリンクします。

| リンク先 | 実体 | 設定内容 |
|---|---|---|
| `~/.config/gh/` | `dotfiles/.config/gh/` | GitHub CLI（`gh` コマンド）の設定 |
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

> **fzf とは？** ファジー検索ツールです。正確なファイル名やコマンドを覚えていなくても、一部を入力するだけで候補を絞り込んで選択できます。

### エイリアス一覧

> **エイリアスとは？** よく使うコマンドに短い別名をつける機能です。たとえば `ls` と打つだけで、実際には `eza --icons` というコマンドが実行されます。

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

> **zoxide とは？** `cd` の賢い代替ツールです。過去に訪れたことのあるディレクトリをディレクトリ名の一部だけで移動できます。例: `z dotfiles` で `~/dotfiles/` に移動。

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

`git` コマンド自体にも短縮コマンドを設定しています。

| エイリアス | 展開 | 説明 |
|---|---|---|
| `git recent` | `git log --oneline -10` | 直近10件のコミットを表示 |
| `git staged` | `git diff --cached` | ステージ済みの差分を表示（コミット前の確認に便利） |
| `git cleanup` | `git branch --merged \| grep -v main \| xargs git branch -d` | マージ済みブランチを一括削除 |
| `git undo` | `git reset HEAD~1 --mixed` | 直前のコミットを取り消し（変更内容は保持） |
| `git unstage` | `git reset HEAD --` | `git add` を取り消す |
| `git lg` | `git log --oneline --graph --decorate --all` | グラフ付きログ |

> **delta とは？** `git diff` の出力をシンタックスハイライト・行番号付きで見やすく表示するツールです。`.gitconfig` に設定済みのため、`git diff` や `git show` を実行するだけで自動的に使われます。

---

## Conventional Commits テンプレート

`git commit` を実行するとエディタに以下のテンプレートが表示されます。

```
# <type>(<scope>): <subject>
```

> **Conventional Commits とは？** コミットメッセージの書き方を統一するルールです。`feat: ログイン機能を追加` のように「何の種類の変更か」を先頭に書くことで、履歴を見たときに変更内容が一目でわかります。

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

> `brew bundle dump` を実行すると、現在インストール済みのパッケージを自動で Brewfile に書き出してくれます。手動で編集する必要はありません。

---

### 新しい設定ファイルを管理対象に追加したいとき

```bash
# 1. dotfiles にコピー
cp ~/.newconfig ~/dotfiles/.newconfig

# 2. 元のファイルをシンボリックリンクに置き換え
ln -sfn ~/dotfiles/.newconfig ~/.newconfig

# 3. install.sh にも追記（次回セットアップ時に自動でリンクされるようにする）
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
