# CH32V003 Arduino Blink

UIAPduino Pro Micro CH32V003 V1.4 向けの、簡潔な Arduino IDE セットアップ
手順です。

## TL;DR

1. `arduino-ide` で Arduino IDE を起動する。
2. **Tools > Board > UIAPduino > Pro Micro CH32V003** を選ぶ。
3. [`ch32v003_arduino_blink.ino`](ch32v003_arduino_blink.ino) を開く。
4. 初回書き込みでは USB を抜き、リセットを押したまま再接続し、リセットを離してから **Upload** を押す。
5. 2 回目以降は USB をつないだまま、リセット、**Upload**、書き込み後にもう一度リセット。

成功時は `Image written.` と表示され、オレンジ LED が点滅します。

## 動作確認環境

- Arduino IDE 2.3.10
- UIAPduino package 1.0.42
- UIAPduino Pro Micro CH32V003 V1.4

内蔵オレンジ LED はピン `2` です。

## 最初に一度だけやること

### 1. Arduino IDE を入れる

好みの方法で Arduino IDE を導入します。公式配布ページは
[Arduino software page](https://www.arduino.cc/en/software) です。

以下の説明では、次のコマンドで起動できる前提です。

```bash
arduino-ide
```

### 2. UIAPduino ボードパッケージを入れる

1. **File > Preferences** を開き、**Additional boards manager URL** に次を追加する。

   ```text
   https://github.com/YuukiUmeta-UIAP/board_manager_files/raw/main/package_uiap.jp_index.json
   ```

2. **Tools > Board > Boards Manager** を開き、`uiap` で検索して **UIAPduino** をインストールする。
3. **Tools > Board > UIAPduino > Pro Micro CH32V003** を選ぶ。

そのほかのボード設定は、基本的にデフォルトのままで構いません。

### 3. Linux の USB 権限を整える

Linux では、メーカー配布の udev ルールを入れます。

```bash
sudo wget -O /etc/udev/rules.d/99-minichlink-uiap.rules \
  https://raw.githubusercontent.com/YuukiUmeta-UIAP/ch32fun/3bfa603f11d493710f2a811b5a2dfad905d9425c/minichlink/99-minichlink-uiap.rules
sudo usermod -aG plugdev "$USER"
sudo udevadm control --reload-rules
sudo udevadm trigger
```

`plugdev` に追加した後は、いったんログアウトしてログインし直します。

## Blink スケッチ

```cpp
#define LED_BUILTIN 2

void setup() {
  // リセット時に run モードと USB write-standby モードを切り替えられるようにする。
  if (FLASH->STATR & (1 << 14)) NVIC_SystemReset();
  SystemReset_StartMode(Start_Mode_BOOT);
  pinMode(PD4, OUTPUT);

  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
```

`setup()` の先頭 3 行は、UIAPduino の Seamless Switch を有効にするための初期化
です。今後も「USB の抜き差しなしで、リセットだけで書き込み待機に入る」運用を
したいなら残しておきます。

## 書き込み

### 初回書き込み

1. **Verify** を押してコンパイルを終える。
2. USB を抜く。
3. リセットを押したまま USB を挿し直し、すぐリセットを離す。
4. すぐ **Upload** を押す。
5. `Image written.` が出るまで待つ。
6. 1 回リセットしてスケッチを実行する。

### 2 回目以降

1. USB はつないだままにする。
2. 1 回リセットして write-standby モードに入る。
3. **Upload** を押す。
4. `Image written.` が出るまで待つ。
5. 1 回リセットして新しいスケッチを実行する。

Seamless Switch で不要になるのは USB の抜き差しだけです。リセット操作自体は、
書き込み前と実行開始時に引き続き必要です。

## Tips / FAQ

- **IDE に "not connected" と出る:** 正常です。書き込みはシリアルポートではなく USB HID と `minichlink` を使います。`/dev/tty*` は選ばなくて構いません。
- **"Could not initialize any supported programmers" が出る:** 先に **Verify** を済ませてから write-standby モードに入り、すぐ **Upload** を押します。
- **USB error `-71`:** 短いデータ対応ケーブル、別の USB ポート、または USB 2.0 ハブを試します。
- **毎回 USB を抜き差しする必要はあるか:** Seamless Switch の 3 行入りスケッチを書き込んだ後は不要です。以後はリセットで足ります。
- **Serial Monitor は使えるか:** デフォルトでは USB シリアルはありません。`Serial.print()` を見たいなら UART ピンへ別の USB-シリアル変換器をつなぎます。
- 書き込み待機中の UIAPduino は 1 台だけ接続する。
- 書き込み成功後にスケッチが始まらない場合は、1 回リセットする。

## 参考

- [Official UIAPduino V1.4 guide](https://www.uiap.jp/en/uiapduino/pro-micro/ch32v003/v1dot4)
- [Arduino IDE downloads](https://www.arduino.cc/en/software)
- [UIAPduino board manager](https://github.com/YuukiUmeta-UIAP/board_manager_files)
- [Repository overview](../README.md)
