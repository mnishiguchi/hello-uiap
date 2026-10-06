# Installation

このページでは、**UIAPduino Pro Micro CH32V003 V1.4** を Arduino CLI から使うための
最小セットアップを説明します。

初めての場合は、この方法をおすすめします。

```text
Editor
  -> arduino-cli
  -> UIAPduino Arduino core
  -> RISC-V toolchain
  -> UIAPduino CH32V003
```

## 1. Arduino CLI をインストールする

### `mise` を使う場合

このリポジトリでは `mise` を使える環境なら、この方法が簡単です。

```sh
mise use --global arduino@latest
```

確認:

```sh
arduino-cli version
```

`mise` の `arduino` エントリは Arduino CLI をインストールします。

- [mise registry](https://mise.jdx.dev/registry.html)

### Arduino 公式の方法を使う場合

`mise` を使わない場合は、Arduino 公式の手順に従ってください。

- [Arduino CLI - Installation](https://docs.arduino.cc/arduino-cli/installation/)
- [Arduino CLI - Getting Started](https://docs.arduino.cc/arduino-cli/getting-started/)

## 2. このリポジトリを取得する

```sh
git clone https://github.com/mnishiguchi/hello-uiap.git
cd hello-uiap
```

CH32V003 の Arduino サンプルだけを使う場合、submodule の初期化は不要です。

CH32V006 の `ch32fun` サンプルも使う場合は、あとで次を実行します。

```sh
git submodule update --init --recursive
```

## 3. `uiapduino` ヘルパーを起動する

```sh
./scripts/uiapduino
```

以降のコマンドは、リポジトリのルートディレクトリで実行してください。

## 4. UIAPduino V003 のボードサポートをセットアップする

```sh
./scripts/uiapduino
```

次を選びます。

```text
Select a UIAPduino board
  -> Pro Micro CH32V003 V1.4

Actions
  -> Set up board support
```

ヘルパーは Arduino CLI を使って、公式 UIAPduino ドキュメントと同じ Board Manager URL と
`UIAP:ch32v` core をセットアップします。

使用する Board Manager URL:

```text
https://github.com/YuukiUmeta-UIAP/board_manager_files/raw/main/package_uiap.jp_index.json
```

インストールされる core / board:

```text
UIAP:ch32v
└── Pro Micro CH32V003
```

これは [UIAPduino Pro Micro CH32V003 V1.4 の公式セットアップ手順](https://www.uiap.jp/en/uiapduino/pro-micro/ch32v003/v1dot4#board-adding-and-sketch-writing)
で案内されている package と同じです。

Arduino の標準ディレクトリはそのまま使います。

```text
~/.arduino15/   # core / toolchain / Board Manager data
~/Arduino/      # sketchbook / libraries / hardware
```

## 5. Linux の USB 権限を確認する

UIAPduino 公式の V1.4 ガイドには Linux 用の udev 設定があります。
この PC で UIAPduino を初めて使う場合は、公式手順の **Linux and Mac** セクションを
確認してください。

- [UIAPduino Pro Micro CH32V003 V1.4 - Official Guide](https://www.uiap.jp/uiapduino/pro-micro/ch32v003/v1dot4)

このリポジトリでは udev ルールそのものを複製せず、最新の公式手順を参照します。

## 6. サンプルスケッチをインストールする

```sh
scripts/install-sketches
```

デフォルトでは次へコピーします。

```text
~/Arduino/sketches/
├── ch32v003_blink/
├── ch32v003_game/
└── ch32v006_blink/
```

## 7. 最初の Blink を Verify する

```sh
./scripts/uiapduino
```

次を選びます。

```text
Pro Micro CH32V003 V1.4
  -> Choose a sketch
  -> sketches/ch32v003_blink
  -> Verify the selected sketch
```

Verify は Arduino IDE の **Verify** と同じく、スケッチをコンパイルします。

## 8. Blink を Upload する

同じメニューから:

```text
Upload the selected sketch
```

ヘルパーが Verify を実行したあと、V003 を書き込み待機モードにする手順を表示します。

基本操作は次のとおりです。

1. USB ケーブルを抜く。
2. 基板のボタンを押したまま USB を接続する。
3. すぐにボタンを離す。
4. ヘルパーに戻って Enter を押す。

書き込みはシリアルポート経由ではないため、通常の Arduino のように `/dev/ttyACM0` などの
ポートを選択する必要はありません。

書き込みに成功すると Blink スケッチが起動し、基板中央のオレンジ LED が点滅します。

## 自分のスケッチを作る

`uiapduino` ヘルパーの **Create a new sketch** を使うと、
`~/Arduino/sketches` の下に新しいスケッチを作成できます。

```sh
./scripts/uiapduino
```

メニューで次を選び、スケッチ名を入力します。

```text
Pro Micro CH32V003 V1.4
  -> Create a new sketch
New sketch name: my_blink
```

作成される構成は次のとおりです。

```text
~/Arduino/sketches/my_blink/
└── my_blink.ino
```

`my_blink.ino` をエディタで開き、たとえば次のコードを書きます。

```cpp
#define LED_BUILTIN 2

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(500);
  digitalWrite(LED_BUILTIN, LOW);
  delay(500);
}
```

リポジトリのルートに戻り、ヘルパーから新しいスケッチを選びます。

```sh
cd /path/to/hello-uiap
./scripts/uiapduino
```

`/path/to/hello-uiap` は、実際に clone したディレクトリへ置き換えてください。

```text
Pro Micro CH32V003 V1.4
  -> Choose a sketch
  -> sketches/my_blink
  -> Verify the selected sketch
  -> Upload the selected sketch
```

ヘルパーを使わずに作成する場合は、Arduino CLI の次のコマンドを使います。

```sh
cd ~/Arduino/sketches
arduino-cli sketch new my_blink
```

詳しくは [Arduino CLI - Getting Started](https://docs.arduino.cc/arduino-cli/getting-started/) を参照してください。

## Arduino CLI を直接使う場合

ヘルパーを使わずに同じ操作をすることもできます。

```sh
FQBN='UIAP:ch32v:CH32V00x_EVT:pnum=CH32V003V1DOT4,upload_method=minichlink'
```

Verify:

```sh
arduino-cli compile \
  --fqbn "$FQBN" \
  ~/Arduino/sketches/ch32v003_blink
```

Upload:

```sh
arduino-cli upload \
  --fqbn "$FQBN" \
  ~/Arduino/sketches/ch32v003_blink
```

`arduino-cli upload` 自体は compile を行わないため、直接使う場合は先に
`arduino-cli compile` を実行します。

## Arduino IDE を使いたい場合

Arduino IDE でも UIAPduino を開発できます。

- [Arduino Software](https://www.arduino.cc/en/software/)
- [UIAPduino Pro Micro CH32V003 V1.4 - Official Guide](https://www.uiap.jp/uiapduino/pro-micro/ch32v003/v1dot4)

このリポジトリでは、手順を再現しやすくするため Arduino CLI を主な説明にしています。

## 次に読むもの

- [CH32V003 Blink](../sketches/ch32v003_blink/README.md)
- [CH32V003 Mini Game](../sketches/ch32v003_game/README.md)
- [Repository README](../README.md)
