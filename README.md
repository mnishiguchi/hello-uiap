# hello-uiap

UIAPduino ボードの基本動作を確認するための Blink サンプルと作業記録です。

## TL;DR

| やりたいこと | 入口 |
| --- | --- |
| CH32V003 を Arduino IDE で試す | [`ch32v003_arduino_blink/`](ch32v003_arduino_blink/) |
| CH32V006 を Arduino IDE で試す | [`ch32v006_arduino_blink/`](ch32v006_arduino_blink/) |
| CH32V006 を `ch32fun` で試す | [`ch32v006_ch32fun_blink/`](ch32v006_ch32fun_blink/) |

初めての場合は、公式の UIAPduino ボードパッケージで使える CH32V003 の
Arduino サンプルから始めるのが簡単です。CH32V006 の Arduino 対応はローカル拡張
を使う実験的な構成です。

## クイックスタート

Arduino サンプルは IDE を起動し、対象ディレクトリの `.ino` ファイルを開きます。

```sh
arduino-ide
```

ボードの選択や書き込み手順は、各サンプルの README を参照してください。

- [CH32V003 Arduino Blink](ch32v003_arduino_blink/README.md)
- [CH32V006 Arduino Blink](ch32v006_arduino_blink/README.md)

CH32V006 を `ch32fun` でビルド、書き込みする場合:

```sh
cd ch32v006_ch32fun_blink
make
make flash
```

詳しくは [CH32V006 ch32fun Blink](ch32v006_ch32fun_blink/README.md) を参照してください。

## 動作確認した開発環境

- ホスト: LMDE 7 (x86-64)
- Arduino IDE: 2.3.10、公式 Linux ZIP 版
- UIAPduino ボードパッケージ: 1.0.42
- ボード: UIAPduino Pro Micro CH32V003 V1.4 / CH32V006 V1.1
- 書き込み: USB HID 経由の `minichlink`

これは動作確認に使った環境であり、必須条件ではありません。

## Arduino IDE の導入

この環境では Arduino IDE を `~/Applications` に置き、`arduino-ide` コマンドで
起動できるようにしています。

```text
~/.local/bin/arduino-ide -> ~/Applications/arduino-ide/arduino-ide
~/Applications/arduino-ide -> ~/Applications/arduino-ide-<version>
```

公式 Linux ZIP 版をこの構成で導入または更新する補助スクリプトがあります。

```sh
./scripts/install-arduino-ide.sh
```

バージョン指定や、変更せずに処理内容を確認する dry-run も可能です。

```sh
./scripts/install-arduino-ide.sh --version 2.3.10
./scripts/install-arduino-ide.sh --version 2.3.10 --dry-run
```

対応環境は Linux x86-64 で、`curl` と `unzip` が必要です。また、
`~/.local/bin` を `PATH` に含めてください。

## リポジトリ構成

- `ch32v003_arduino_blink/`: CH32V003 用 Arduino Blink
- `ch32v006_arduino_blink/`: CH32V006 用 Arduino Blink（実験的）
- `ch32v006_ch32fun_blink/`: CH32V006 用の最小 C Blink
- `arduino_support/`: CH32V006 を Arduino IDE から使うためのローカル拡張
- `ch32fun/`: CH32V006 のビルドと書き込みに使う upstream ツールキット
- `scripts/`: Arduino IDE の導入補助スクリプト
- `worklog/`: セットアップ、判断、実機テストの記録

`ch32fun/` はヘッダ、ビルド設定、`minichlink`、参考実装を提供します。
