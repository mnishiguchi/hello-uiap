# Experimental CH32V006 Arduino Support

These files document the local extension applied to UIAPduino core `1.0.42`:

- `boards.local.txt`: additional board definition loaded by Arduino
- `platform.local.txt`: V006 upload command using the project's `minichlink`

Install these files into the matching UIAP core directory in your Arduino data
folder:

```text
<arduino-data>/packages/UIAP/hardware/ch32v/1.0.42/
```

On Linux, `<arduino-data>` is typically `~/.arduino15`.

Arduino Boards Manager may replace the customization when the UIAPduino package
is updated. Review the new package before reapplying it because the core version
or upload support may have changed.
