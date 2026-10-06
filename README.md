# hello-uiap

UIAPduino を使って Arduino / 組み込み開発を学ぶためのサンプル集です。

初めてこのリポジトリを使う場合は、**UIAPduino Pro Micro CH32V003 V1.4** と
**Arduino CLI** から始めるのがおすすめです。

## まずはここから

必要なもの:

- UIAPduino Pro Micro CH32V003 V1.4
- データ通信対応の USB ケーブル
- `arduino-cli`
- Git

### 1. Arduino CLI を入れる

`mise` を使っている場合:

```sh
mise use --global arduino@latest
arduino-cli version
```

`mise` を使わない場合は、Arduino 公式のインストール手順を参照してください。

- [Arduino CLI - Installation](https://docs.arduino.cc/arduino-cli/installation/)

### 2. このリポジトリを取得する

```sh
git clone https://github.com/mnishiguchi/hello-uiap.git
cd hello-uiap
```

### 3. `uiapduino` を起動する

```sh
./scripts/uiapduino
```

以降のコマンドは、リポジトリのルートディレクトリで実行してください。

### 4. サンプルスケッチを Arduino の sketchbook にコピーする

```sh
scripts/install-sketches
```

サンプルは次の場所へコピーされます。

```text
~/Arduino/sketches/
```

### 5. Blink を Verify / Upload する

```sh
./scripts/uiapduino
```

メニューで次を選びます。

```text
Pro Micro CH32V003 V1.4
  -> Set up board support
  -> Choose a sketch
  -> sketches/ch32v003_blink
  -> Verify the selected sketch
  -> Upload the selected sketch
```

書き込みに成功すると、基板中央のオレンジ LED が点滅します。

詳しいセットアップ手順は [Installation](docs/installation.md) を参照してください。

## `uiapduino` コマンドについて

[`scripts/uiapduino`](scripts/uiapduino) は `arduino-cli` の薄いラッパーです。

主に次の操作を簡単にします。

- UIAPduino のボードサポートをセットアップする
- `~/Arduino` 以下のスケッチを選ぶ
- `~/Arduino/sketches` に新しいスケッチを作る
- Verify（コンパイル）する
- Upload（コンパイル + 書き込み）する

Arduino 独自のビルド処理を再実装しているわけではなく、実際の処理は
`arduino-cli` に任せています。

## サンプル

| サンプル | ボード | 状態 |
| --- | --- | --- |
| [CH32V003 Blink](sketches/ch32v003_blink/) | CH32V003 V1.4 | **最初におすすめ** |
| [CH32V003 Mini Game](sketches/ch32v003_game/) | CH32V003 V1.4 | OLED / ボタン / ブザー |
| [CH32V006 ch32fun Blink](ch32fun_projects/ch32v006_blink/) | CH32V006 V1.1 | V006 の推奨実験パス |
| [CH32V006 Arduino Blink](sketches/ch32v006_blink/) | CH32V006 V1.1 | 実験的なローカル拡張 |

## CH32V006 について

CH32V006 V1.1 は CH32V003 と同じ Arduino CLI 手順では扱いません。
公式ドキュメントでは Arduino IDE / PlatformIO は未対応のため、このリポジトリでは
`ch32fun` + `minichlink` を基準となる開発パスにしています。

```sh
git submodule update --init --recursive
cd ch32fun_projects/ch32v006_blink
make
make flash
```

詳しくは [CH32V006 ch32fun Blink](ch32fun_projects/ch32v006_blink/README.md) を参照してください。

## 公式ドキュメント

- [UIAPduino Pro Micro CH32V003 V1.4](https://www.uiap.jp/uiapduino/pro-micro/ch32v003/v1dot4)
- [UIAPduino Pro Micro CH32V006 V1.1](https://www.uiap.jp/uiapduino/pro-micro/ch32v006/v1dot1)
- [Arduino CLI](https://docs.arduino.cc/arduino-cli/)
- [Arduino CLI - Getting Started](https://docs.arduino.cc/arduino-cli/getting-started/)
- [UIAPduino Board Manager package](https://github.com/YuukiUmeta-UIAP/board_manager_files)

ハードウェア固有の注意事項や最新の公式手順は、まず UIAP の公式ドキュメントを
確認してください。

## リポジトリ構成

```text
hello-uiap/
├── docs/               # セットアップガイド / ADR
├── sketches/           # Arduino スケッチ
├── ch32fun_projects/   # ch32fun を使うサンプル
├── scripts/            # CLI 用ヘルパー
├── arduino_support/    # V006 Arduino 実験用のローカル拡張
├── tests/              # ホスト側テスト
└── worklog/            # 調査・実機テストの記録
```

詳細な検証メモは `worklog/` に残しています。初めて使う場合は、まずこの README と
[Installation](docs/installation.md) だけ読めば十分です。

設計上の判断は [Architecture Decision Records](docs/adr/README.md) にまとめています。
