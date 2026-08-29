# hello-uiap

Small bring-up projects and notes for UIAP boards.

## TL;DR

- `ch32v003_arduino_blink`: Arduino IDE blink for the CH32V003 board, with its own `README.md`
- `ch32v006_arduino_blink`: experimental Arduino IDE blink for the CH32V006 board
- `ch32v006_ch32fun_blink`: lean C/`ch32fun` blink for the CH32V006 board
- `ch32fun`: upstream toolkit used by the V006 project
- `worklog`: dated notes from setup and test sessions

## Directory map

### `ch32v003_arduino_blink`

Arduino sketch for the UIAP CH32V003 board. This is the beginner-friendly path
using Arduino IDE and the UIAP board package.

### `ch32v006_ch32fun_blink`

Minimal C blink example for the UIAP CH32V006 board. This does not use Arduino
IDE. It builds and flashes with `ch32fun` and `minichlink`.

### `ch32v006_arduino_blink`

Arduino sketch for the UIAP CH32V006 board. It uses the V006 support already
present in the installed core plus the local board and upload definitions kept
in `arduino_support/`.

### `ch32fun`

Local checkout of the upstream CH32 development toolkit.

This directory is here because the V006 project depends on it for:

- headers and build files
- the `minichlink` uploader
- reference examples for CH32 chips

If this workspace becomes Arduino-only later, this directory can be removed.

### `worklog`

Day-by-day notes about setup decisions, uploads, and test results.

## Typical use

For CH32V003 with Arduino IDE:

```sh
arduino-ide
```

Open:

```text
~/Projects/uiap/hello-uiap/ch32v003_arduino_blink/ch32v003_arduino_blink.ino
```

Guide:

```text
~/Projects/uiap/hello-uiap/ch32v003_arduino_blink/README.md
```

For CH32V006 with `ch32fun`:

```sh
cd ~/Projects/uiap/hello-uiap/ch32v006_ch32fun_blink
make
make flash
```

For CH32V006 with Arduino IDE:

```sh
arduino-ide
```

Open:

```text
~/Projects/uiap/hello-uiap/ch32v006_arduino_blink/ch32v006_arduino_blink.ino
```
