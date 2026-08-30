# CH32V006 Arduino Blink

## TL;DR

1. `arduino-ide` で Arduino IDE を起動する。
2. **Tools > Board > UIAPduino > Pro Micro CH32V006 (Experimental)** を選ぶ。
3. [`ch32v006_arduino_blink.ino`](ch32v006_arduino_blink.ino) を開く。
4. **Upload** を押す。リセットボタンのタイミング合わせは不要。

内蔵 LED は `PC3` で、短く 2 回点滅したあと少し止まるパターンを繰り返します。

## 状態

これは UIAPduino core `1.0.42` に対する実験的なローカル拡張です。core 自体は
すでに `CH32V006K8` の Arduino 対応を含んでいますが、この拡張でボードメニュー
から選べるようにし、オンボード書き込み器経由でアップロードできるようにしてい
ます。

公式の UIAP V1.1 ドキュメントでは、現時点で Arduino IDE はサポート対象外です。
このリポジトリで確認できているのは、基本的な GPIO とタイミング処理です。その他
の Arduino API やライブラリは、個別に検証が必要です。

## ローカル拡張の導入

[`../arduino_support`](../arduino_support) のファイルを、Arduino データディレクトリ
内の対応する UIAP core ディレクトリへコピーします。

```text
<arduino-data>/packages/UIAP/hardware/ch32v/1.0.42/
```

Linux では `<arduino-data>` は通常 `~/.arduino15` です。

## UIAPduino ボードパッケージ更新後

Boards Manager で更新すると、ローカル追加したボード定義が上書きされることがあり
ます。その場合は、このプロジェクトの `arduino_support/` を再適用してから
Arduino IDE を再起動します。
