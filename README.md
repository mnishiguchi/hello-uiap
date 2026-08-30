# hello-uiap

UIAP ボード向けの小さな動作確認プロジェクトと作業メモです。

## TL;DR

- `ch32v003_arduino_blink`: CH32V003 向けの Arduino IDE blinky。詳細は各ディレクトリの `README.md`
- `ch32v006_arduino_blink`: CH32V006 向けの Arduino IDE blinky
- `ch32v006_ch32fun_blink`: CH32V006 向けの `ch32fun` ベース最小 blinky
- `ch32fun`: V006 プロジェクトで使っている upstream ツールキット
- `worklog`: 日付ごとのセットアップ記録と実験メモ
- `scripts`: Arduino IDE の導入を補助するスクリプト

## ディレクトリ概要

### `ch32v003_arduino_blink`

UIAP CH32V003 ボード向けの Arduino スケッチです。Arduino IDE と
UIAPduino ボードパッケージを使う、いちばん素直な入り口です。

### `ch32v006_ch32fun_blink`

UIAP CH32V006 ボード向けの最小 C blinky です。Arduino IDE は使わず、
`ch32fun` と `minichlink` でビルドと書き込みを行います。

### `ch32v006_arduino_blink`

UIAP CH32V006 ボード向けの Arduino スケッチです。インストール済み core
に含まれている V006 サポートと、`arduino_support/` に置いたローカル拡張
を使います。

### `ch32fun`

upstream の CH32 開発ツールキットをローカルに置いたものです。

このディレクトリがある理由:

- ヘッダやビルドファイルが必要
- `minichlink` 書き込みツールを使う
- CH32 系の参考実装を参照できる

将来この作業場が Arduino 専用になれば、ここは不要になる可能性があります。

### `worklog`

セットアップ判断、書き込み手順、テスト結果を日付ごとに残したメモです。

### `scripts`

Linux 用 Arduino IDE の導入や更新を楽にする補助スクリプトです。

## Arduino IDE コマンド

Linux では、Arduino IDE はターミナルから次で起動できます。

```sh
arduino-ide
```

このリポジトリでは、次の 2 本のシンボリックリンクを前提にしています。

```text
~/.local/bin/arduino-ide -> ~/Applications/arduino-ide/arduino-ide
~/Applications/arduino-ide -> ~/Applications/arduino-ide-<version>
```

新しい IDE を入れたら、更新すべきなのは 2 本目だけです。

```sh
ln -sfn "$HOME/Applications/arduino-ide-<version>" "$HOME/Applications/arduino-ide"
```

`~/.local/bin` が `PATH` に入っている必要があります。

公式 Linux ZIP 版の Arduino IDE を導入または更新するには:

```sh
./scripts/install-arduino-ide.sh
```

デフォルトでは最新版を入れます。バージョン指定や dry-run も可能です。

```sh
./scripts/install-arduino-ide.sh --version 2.3.10
./scripts/install-arduino-ide.sh --version 2.3.10 --dry-run
```

このスクリプトは Linux x86-64 向けで、`curl` と `unzip` が必要です。

## よく使う流れ

CH32V003 を Arduino IDE で触る場合:

```sh
arduino-ide
```

開くファイル:

```text
ch32v003_arduino_blink/ch32v003_arduino_blink.ino
```

手順書:

```text
ch32v003_arduino_blink/README.md
```

CH32V006 を `ch32fun` で触る場合は、リポジトリ直下から:

```sh
cd ch32v006_ch32fun_blink
make
make flash
```

CH32V006 を Arduino IDE で触る場合:

```sh
arduino-ide
```

開くファイル:

```text
ch32v006_arduino_blink/ch32v006_arduino_blink.ino
```
