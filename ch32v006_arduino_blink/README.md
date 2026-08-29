# CH32V006 Arduino Blink

## TL;DR

1. Start Arduino IDE with `arduino-ide`.
2. Select **Tools > Board > UIAPduino > Pro Micro CH32V006 (Experimental)**.
3. Open [`ch32v006_arduino_blink.ino`](ch32v006_arduino_blink.ino).
4. Click **Upload**. No reset-button timing is required.

The onboard LED on `PC3` repeats two short flashes followed by a pause.

## Status

This is an experimental local extension of UIAPduino core `1.0.42`. The core
already provides Arduino support for the `CH32V006K8`; this extension exposes
it in the board menu and uploads through the board's onboard programmer.

The official UIAP V1.1 documentation does not currently support Arduino IDE.
Basic GPIO and timing are tested here; other Arduino APIs and libraries may
still need validation.

## Install the local extension

Copy the files from [`../arduino_support`](../arduino_support) into the matching
UIAP core directory in your Arduino data folder:

```text
<arduino-data>/packages/UIAP/hardware/ch32v/1.0.42/
```

On Linux, `<arduino-data>` is typically `~/.arduino15`.

## After updating the UIAPduino board package

A Boards Manager update may replace the local board entry. Reapply the files
kept in `arduino_support/` from this project, then restart Arduino IDE.
