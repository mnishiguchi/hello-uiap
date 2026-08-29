# CH32V003 Arduino Blink

Concise Arduino IDE setup for the UIAPduino Pro Micro CH32V003 V1.4.

## TL;DR

1. Start Arduino IDE with `arduino-ide`.
2. Select **Tools > Board > UIAPduino > Pro Micro CH32V003**.
3. Open [`ch32v003_arduino_blink.ino`](ch32v003_arduino_blink.ino).
4. First upload: disconnect USB, hold reset while reconnecting, release reset,
   then click **Upload**.
5. Later uploads: leave USB connected, press reset, click **Upload**, then press
   reset again to run.

Success is reported as `Image written.`. The orange LED should blink.

## Tested with

- Arduino IDE 2.3.10
- UIAPduino package 1.0.42
- UIAPduino Pro Micro CH32V003 V1.4

The built-in orange LED is pin `2`.

## One-time setup

### 1. Install Arduino IDE

Install Arduino IDE by your preferred method. The official download is on the
[Arduino software page](https://www.arduino.cc/en/software).

Examples below assume Arduino IDE can be started with:

```bash
arduino-ide
```

### 2. Install the UIAPduino board package

1. Open **File > Preferences** and add this **Additional boards manager URL**:

   ```text
   https://github.com/YuukiUmeta-UIAP/board_manager_files/raw/main/package_uiap.jp_index.json
   ```

2. Open **Tools > Board > Boards Manager**, search for `uiap`, and install
   **UIAPduino**.
3. Select **Tools > Board > UIAPduino > Pro Micro CH32V003**.

Keep all other board options at their defaults.

### 3. Configure Linux USB access

On Linux, install the manufacturer's udev rule:

```bash
sudo wget -O /etc/udev/rules.d/99-minichlink-uiap.rules \
  https://raw.githubusercontent.com/YuukiUmeta-UIAP/ch32fun/3bfa603f11d493710f2a811b5a2dfad905d9425c/minichlink/99-minichlink-uiap.rules
sudo usermod -aG plugdev "$USER"
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Log out and back in after joining `plugdev`.

## Blink sketch

```cpp
#define LED_BUILTIN 2

void setup() {
  // Let reset alternate between run and USB write-standby modes.
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

The three lines at the start of `setup()` enable UIAPduino's Seamless Switch.
Keep them in future sketches if you want reset-only mode switching.

## Upload

### First upload

1. Click **Verify** and wait for compilation to finish.
2. Disconnect USB.
3. Hold reset while reconnecting USB, then immediately release reset.
4. Click **Upload** promptly.
5. Wait for `Image written.`.
6. Press reset once to run the sketch.

### Later uploads

1. Keep USB connected.
2. Press reset once to enter write-standby mode.
3. Click **Upload**.
4. Wait for `Image written.`.
5. Press reset once to run the new sketch.

Seamless Switch removes cable reconnection; it does not remove the reset
presses.

## Tips and FAQ

- **IDE says "not connected":** Expected. Upload uses USB HID and `minichlink`,
  not a serial port. Do not select a `/dev/tty*` port.
- **"Could not initialize any supported programmers":** Click **Verify**
  first, enter write-standby mode, then click **Upload** promptly.
- **USB error `-71`:** Try a short data cable, another USB port, or a USB 2.0
  hub.
- **Reconnect USB every time?** Only after flashing a sketch without the
  Seamless Switch lines. Otherwise use reset.
- **Serial Monitor:** USB serial is not available by default. Use a separate
  USB-to-serial adapter on the UART pins for `Serial.print()`.
- Connect only one UIAPduino waiting for upload.
- If upload succeeds but the sketch does not start, press reset once.

## References

- [Official UIAPduino V1.4 guide](https://www.uiap.jp/en/uiapduino/pro-micro/ch32v003/v1dot4)
- [Arduino IDE downloads](https://www.arduino.cc/en/software)
- [UIAPduino board manager](https://github.com/YuukiUmeta-UIAP/board_manager_files)
- [Repository overview](../README.md)
