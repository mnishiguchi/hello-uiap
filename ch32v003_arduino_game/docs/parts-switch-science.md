# スイッチサイエンスでそろえる部品

CH32V003 Arduino Mini Game をブレッドボードで再現するための部品表です。
価格と在庫は 2026-09-01 にスイッチサイエンスの通販サイトで確認しました。
価格は税込みで、送料、工具、消耗品は含みません。

## 結論

必要な部品はスイッチサイエンスだけでそろえられます。
在庫のある低価格な OLED を使用した構成は **4,527 円**です。

この構成では Grove 接続の OLED をブレッドボードへつなぐために、Grove－Qwiic
変換ハーネスと Qwiic ピッチ変換基板を使用します。部品数を減らしたい場合は、
より高価な Adafruit 製 OLED を使う **6,826 円**の構成も選べます。

## 在庫のある推奨構成

| 部品 | SKU | 数量 | 単価 | 小計 | 確認時の在庫 |
| --- | ---: | ---: | ---: | ---: | ---: |
| [UIAPduino Pro Micro CH32V003 V1.4](https://www.switch-science.com/products/9914) | `9914` | 1 | 290 円 | 290 円 | 97 |
| [Grove - 0.96 インチ OLED（SSD1315）](https://www.switch-science.com/products/7002) | `7002` | 1 | 1,122 円 | 1,122 円 | 11 |
| [Qwiic－Grove 互換変換ハーネス](https://www.switch-science.com/products/9483) | `9483` | 1 | 275 円 | 275 円 | 100+ |
| [Qwiic / STEMMA QT ピッチ変換基板](https://www.switch-science.com/products/9719) | `9719` | 1 | 484 円 | 484 円 | 15 |
| [高さ 2 mm のコンスルー 20 ピン](https://www.switch-science.com/products/7447) | `7447` | 2 | 462 円 | 924 円 | 93 |
| [1×40 両方長いピンヘッダ](https://www.switch-science.com/products/1939) | `1939` | 1 | 154 円 | 154 円 | 100+ |
| [タクトスイッチ](https://www.switch-science.com/products/38) | `38` | 3 | 87 円 | 261 円 | 58 |
| [圧電スピーカー](https://www.switch-science.com/products/472) | `472` | 1 | 104 円 | 104 円 | 84 |
| [普通のブレッドボード](https://www.switch-science.com/products/313) | `313` | 1 | 440 円 | 440 円 | 100+ |
| [固いジャンパワイヤ（ブレッドボード用）](https://www.switch-science.com/products/314) | `314` | 1 | 473 円 | 473 円 | 100+ |
| | | | **合計** | **4,527 円** | |

在庫数は確認時点の表示です。注文前に各商品ページで再確認してください。

## OLED の接続

SKU `7002` は 128×64、I2C、SSD1315 の白色 OLED で、3.3 V と 5 V の
両方に対応します。このゲームは SSD1306/SSD1315 を直接制御し、起動時に
I2C アドレス `0x3C` と `0x3D` を順番に探します。

OLED は Grove コネクタのみなので、次の順に接続します。

```text
Grove OLED
    -> Qwiic-Grove 変換ハーネス (SKU 9483)
    -> Qwiic ピッチ変換基板 (SKU 9719)
    -> ブレッドボード
```

ピンヘッダから 4 ピンを切り出し、Qwiic ピッチ変換基板へはんだ付けします。
基板のシルク印刷を確認して、UIAPduino へ次のように配線します。

```text
V+  -> 3V3
GND -> GND
SDA -> D3 / PC1
SCL -> D4 / PC2
```

ピッチ変換基板には I2C プルアップ抵抗が実装されています。そのまま使用できます。

### 部品数を減らす OLED

[STEMMA QT/Qwiic 互換 128×64 OLED](https://www.switch-science.com/products/6105)
（SKU `6105`、4,180 円、確認時在庫 9）は SSD1306 を搭載し、ゲームと互換性が
あります。標準ピッチの端子へピンヘッダをはんだ付けすれば、変換ハーネスと
ピッチ変換基板を使わずに接続できます。

推奨構成の SKU `7002`、`9483`、`9719` を SKU `6105` に置き換えた場合の
合計は **6,826 円**です。初期設定は I2C で、リセット端子の配線は不要です。

### 現在は使えない最短経路

[Grove－4 ピン－ジャンパオスケーブル](https://www.switch-science.com/products/6245)
（SKU `6245`）を使えば、Grove OLED を変換基板なしでブレッドボードへ接続できます。
ただし、2026-09-01 の確認時点では売り切れでした。

## UIAPduino のブレッドボード実装

UIAPduino の単品にはブレッドボード用の足が付属しません。製品ページで案内されている
高さ 2 mm、2.54 mm ピッチのコンスルーを使用します。

20 ピンのコンスルー 2 本をそれぞれ 12 ピンに切り分け、UIAPduino の左右へ
差し込みます。すでに適合するコンスルーやピンヘッダを取り付けている場合、
SKU `7447` は購入不要です。

## ボタンと圧電スピーカー

ボタンは同じタクトスイッチを 3 個使用します。各スイッチを GPIO と GND の間に
接続し、スケッチの内部プルアップを使用します。

```text
D8  / PC6 -> LEFT   -> GND
D9  / PC7 -> RIGHT  -> GND
D10 / PD0 -> ACTION -> GND
```

SKU `472` は、ゲーム側から異なる周波数を与えて鳴らす他励式の圧電スピーカーです。
自励式ブザーとは異なり、高音と低音を鳴らし分けられます。

```text
圧電スピーカー + -> D5 / PC3
圧電スピーカー - -> GND
```

圧電スピーカーの線は細いため、商品ページでもピンヘッダへのはんだ付けが推奨されて
います。SKU `1939` の残りから 2 ピンを切り出して使用できます。

## USB ケーブル

UIAPduino への書き込みには、給電専用ではなくデータ通信対応の USB Type-C
ケーブルが必要です。

USB Type-C ポートを備えたホストでは、在庫のある
[USB 3.1 Type-C－Type-C ケーブル 1 m](https://www.switch-science.com/products/10928)
（SKU `10928`、1,210 円）を追加できます。これを含む合計は **5,737 円**です。

USB Type-A ポート用の
[USB 3.1 Type-A－Type-C ケーブル](https://www.switch-science.com/products/3864)
（SKU `3864`）は、確認時点では売り切れでした。Type-A を使う場合は、手持ちの
データ通信対応ケーブルを使うか、別の販売店で用意します。

## 費用の目安

| 条件 | 合計 |
| --- | ---: |
| 在庫のある推奨構成をすべて購入 | 4,527 円 |
| UIAPduino と取り付け済みの足を持っている | 3,313 円 |
| 推奨構成に Type-C－Type-C ケーブルを追加 | 5,737 円 |
| Adafruit 製 OLED を使う簡潔な構成 | 6,826 円 |

はんだごて、はんだ、ニッパー、送料は合計に含みません。

## 注文用チェックリスト

```text
スイッチサイエンス
[ ] 9914 x 1  UIAPduino Pro Micro CH32V003 V1.4
[ ] 7002 x 1  Grove 128x64 I2C OLED (SSD1315)
[ ] 9483 x 1  Qwiic-Grove adapter harness
[ ] 9719 x 1  Qwiic / STEMMA QT breakout
[ ] 7447 x 2  2 mm high 20-pin conthrough
[ ] 1939 x 1  1x40 long pin header
[ ]   38 x 3  tactile switches
[ ]  472 x 1  passive piezo speaker
[ ]  313 x 1  breadboard
[ ]  314 x 1  rigid jumper wire set

必要な場合のみ
[ ] 10928 x 1  USB Type-C to Type-C data cable
```

配線全体は [ゲーム README](../README.md#配線) を参照してください。
秋月電子の構成は [秋月電子でそろえる部品](parts-akizuki.md) にまとめています。
