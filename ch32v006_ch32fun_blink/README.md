# UIAPduino Pro Micro CH32V006 Blink

## TL;DR

From this directory:

```sh
make
make flash
```

The built-in LED on `PC3` should repeat two short flashes followed by a pause.
No reset-button timing is required.

## Prerequisites

- UIAPduino Pro Micro CH32V006 V1.1 connected by USB
- `riscv64-unknown-elf-gcc`, `make`, `libusb`, and `libudev`
- A current `ch32fun` checkout at `../ch32fun`
- A built `../ch32fun/minichlink/minichlink`

Build minichlink after cloning or updating ch32fun:

```sh
make -C ../ch32fun/minichlink
```

## Build and upload

From the repository root:

```sh
cd ch32v006_ch32fun_blink
make
make flash
```

The Makefile selects `CH32V006` and explicitly targets the board's onboard
programmer with USB ID `1209:b806`.

## Tips and FAQ

### Can I use Arduino IDE?

The official V006 V1.1 documentation lists Arduino IDE and PlatformIO as
unsupported. This project also contains an experimental local Arduino setup at
`../ch32v006_arduino_blink`; keep this ch32fun version as the supported fallback.

### Do I need to press reset before uploading?

No. The onboard programmer flashes the V006 directly.

### Which pin is the built-in LED?

`PC3`. Do not adapt the stock ch32fun blink example without reviewing it: that
example also drives `PC0`, which must not be used on this UIAPduino board because
it can reset or disable the onboard V003 debugger.

### Why two short flashes?

The board's factory firmware already blinks at a steady 250 ms rate. The custom
pattern makes a successful upload immediately obvious.

### Upload is unreliable

Use a known-good data cable, preferably 1 m or shorter, and connect it directly
to the host before trying a hub.
