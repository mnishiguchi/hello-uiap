# UIAPduino Pro Micro CH32V006 Blink

## TL;DR

このディレクトリで次を実行します。

```sh
make
make flash
```

内蔵 LED `PC3` が、短く 2 回点滅したあと少し止まるパターンを繰り返せば成功です。
リセットボタンのタイミング合わせは不要です。

## 前提

- UIAPduino Pro Micro CH32V006 V1.1 を USB 接続している
- `riscv64-unknown-elf-gcc`, `make`, `libusb`, `libudev` が入っている
- `../ch32fun` に現行の `ch32fun` checkout がある
- `../ch32fun/minichlink/minichlink` がビルド済み

`ch32fun` を clone 直後または更新直後に使う場合は、先に `minichlink` をビルド
します。

```sh
make -C ../ch32fun/minichlink
```

## ビルドと書き込み

リポジトリ直下から:

```sh
cd ch32v006_ch32fun_blink
make
make flash
```

Makefile では `CH32V006` を選び、USB ID `1209:b806` のオンボード書き込み器を
明示的に使うようにしています。

## Tips / FAQ

### Arduino IDE は使えるか

公式の V006 V1.1 ドキュメントでは、Arduino IDE と PlatformIO は未対応です。
このリポジトリには、実験用の Arduino 版として `../ch32v006_arduino_blink` も
ありますが、確実に戻れる基準線としてはこの `ch32fun` 版を残しておくのが無難
です。

### 書き込み前にリセットは必要か

不要です。オンボード書き込み器が V006 へ直接書き込みます。

### 内蔵 LED はどのピンか

`PC3` です。stock の `ch32fun` blinky をそのまま流用するのは避けてください。
あの例は `PC0` も触りますが、この UIAPduino ボードでは `PC0` がオンボード V003
デバッガに干渉し、リセットや無効化を引き起こす可能性があります。

### なぜ 2 回点滅なのか

工場出荷時ファームウェアは一定間隔の点滅です。独自パターンにしておくと、書き
込み成功が見た目ですぐ分かります。

### 書き込みが不安定

1 m 以下の短いデータ対応ケーブルを優先し、まずはハブなしでホストへ直結して試し
ます。
