# CH32V003 Blink

UIAPduino Pro Micro CH32V003 V1.4 の内蔵 LED を点滅させる、最初の動作確認用
スケッチです。

初めての場合は、先に [Installation](../../docs/installation.md) を済ませてください。

## 期待する動作

書き込み後、基板中央のオレンジ LED が点滅します。

内蔵 LED は Arduino pin `2` (`PC0`) です。

## `uiapduino` ヘルパーで実行する

サンプルをまだ sketchbook へコピーしていない場合:

```sh
scripts/install-sketches
```

その後:

```sh
./scripts/uiapduino
```

次を選びます。

```text
Pro Micro CH32V003 V1.4
  -> Choose a sketch
  -> sketches/ch32v003_blink
  -> Verify the selected sketch
  -> Upload the selected sketch
```

Upload の前に、ヘルパーが V003 を書き込み待機モードにする手順を表示します。

## Arduino CLI を直接使う

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

## スケッチ

[`ch32v003_blink.ino`](ch32v003_blink.ino) は、通常の Blink に UIAPduino の
**Seamless Switch** 用コードを加えています。

```cpp
// UIAPduino Pro Micro CH32V003 V1.4 built-in orange LED.
#define LED_BUILTIN 2

void setup() {
  // Let reset alternate between running and USB write-standby modes.
  if (FLASH->STATR & (1 << 14)) NVIC_SystemReset();
  SystemReset_StartMode(Start_Mode_BOOT);
  pinMode(PD4, OUTPUT);

  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(500);
  digitalWrite(LED_BUILTIN, LOW);
  delay(250);
}
```

Seamless Switch の 3 行を入れておくと、初回書き込み後はリセットボタンで
**実行モード / 書き込み待機モード**を切り替えられます。

詳しい仕組みは UIAPduino 公式ドキュメントを参照してください。

## Tips

- Upload に通常のシリアルポート選択は不要です。
- USB ケーブルは充電専用ではなく、データ通信対応のものを使います。
- 書き込みが不安定な場合は、短い USB ケーブルや別の USB ポートを試します。
- Linux で権限エラーになる場合は、公式ガイドの Linux 用 udev 設定を確認します。

## 参考

- [UIAPduino Pro Micro CH32V003 V1.4 - Official Guide](https://www.uiap.jp/uiapduino/pro-micro/ch32v003/v1dot4)
- [UIAPduino Board Manager package](https://github.com/YuukiUmeta-UIAP/board_manager_files)
- [Arduino CLI](https://docs.arduino.cc/arduino-cli/)
- [Installation](../../docs/installation.md)
