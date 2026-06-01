# dotfiles

個人の設定ファイル（dotfiles）を一元管理するリポジトリです。

---

## 管理しているファイル

| ファイル | 用途 |
|---|---|
| `.zshrc` | zsh の設定（エイリアス、補完、プロンプトなど） |
| `.zprofile` | ログインシェル用の設定（Homebrew PATH など） |
| `.gitconfig` | Git のユーザー情報・エイリアス設定 |
| `.gitignore_global` | 全リポジトリ共通の Git 除外ルール |
| `.vimrc` | Vim の設定 |
| `.config/gh/config.yml` | GitHub CLI の設定 |
| `.config/karabiner/karabiner.json` | Karabiner-Elements のキーボード設定 |

---

## 仕組み

`~/dotfiles/` に実体ファイルを置き、ホームディレクトリからシンボリックリンクで参照します。

```
~/.zshrc  →  ~/dotfiles/.zshrc（実体）
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

# 3. 設定を即時反映
source ~/.zshrc
```

> **注意:** `install.sh` は既存ファイルを上書きせず、`~/.dotfiles_backup/` に退避してからリンクを張ります。

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

> `~/.zshrc` はシンボリックリンクなので、`~/.zshrc` を編集しても同じです。

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
git commit -m "Add .newconfig"
git push
```

---

## ディレクトリ構成

```
~/dotfiles/
├── .config/
│   ├── gh/
│   │   └── config.yml       # GitHub CLI 設定
│   └── karabiner/
│       └── karabiner.json   # Karabiner 設定
├── .gitconfig
├── .gitignore               # dotfiles リポジトリ自体の除外ルール
├── .gitignore_global        # 全 Git リポジトリ共通の除外ルール
├── .gitflow_export
├── .hgignore_global
├── .stCommitMsg
├── .vimrc
├── .zprofile
├── .zshrc
├── install.sh               # セットアップスクリプト
└── README.md                # このファイル
```
