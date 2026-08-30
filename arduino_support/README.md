# Experimental CH32V006 Arduino Support

このディレクトリのファイルは、UIAPduino core `1.0.42` に対してローカルで
加えている拡張内容を説明します。

- `boards.local.txt`: Arduino が読み込む追加ボード定義
- `platform.local.txt`: このプロジェクトの `minichlink` を使う V006 用書き込み設定

これらのファイルは、Arduino のデータディレクトリ内にある対応する UIAP core
ディレクトリへ配置します。

```text
<arduino-data>/packages/UIAP/hardware/ch32v/1.0.42/
```

Linux では `<arduino-data>` は通常 `~/.arduino15` です。

UIAPduino パッケージを Boards Manager で更新すると、このローカル拡張が上書き
されることがあります。再適用する前に、新しいパッケージ側で core のバージョン
や書き込み手順が変わっていないか確認してください。
