# 0001: 公式 UIAPduino のセットアップを既定とする

## 状態

採用

## 背景

`hello-uiap` は UIAPduino を使って Arduino / 組み込み開発を学ぶためのリポジトリである。

CH32V003 には複数の Arduino core / Board Manager package を利用できるが、学習用リポジトリで
公式ドキュメントと異なる package を既定にすると、ボード名、FQBN、書き込み方法などの差分が
増え、初めて使う人が混乱しやすい。

この判断は、既存のドキュメントと helper script を公式 UIAPduino の手順へ揃えた時点の方針を
遡及して記録する。

## 決定

UIAPduino のセットアップは、可能な限り UIAP 公式ドキュメントと公式 Board Manager package を
既定とする。

CH32V003 V1.4 では、次の公式 package を使用する。

```text
https://github.com/YuukiUmeta-UIAP/board_manager_files/raw/main/package_uiap.jp_index.json
```

Arduino CLI でも Arduino IDE と同じ package / core を使用し、CLI を使うこと自体を理由に別の
Arduino core へ切り替えない。

公式手順から外れる場合は、必要な理由をドキュメントに明記する。

## 理由

- UIAP 公式ドキュメントとリポジトリの手順を比較しやすい。
- package 名、board 名、FQBN、書き込み手順の差分を減らせる。
- 初学者が「どちらの手順が正しいか」を判断する必要を減らせる。
- 独自構成の保守コストを抑えられる。

## 影響

- CH32V003 の既定 core は `UIAP:ch32v` となる。
- `scripts/uiapduino` も公式 package / core をセットアップする。
- 別 package 固有の機能が必要な場合は、既定パスと混ぜずに明示的な代替手段として扱う。
- UIAP 公式ドキュメントの変更があった場合は、このリポジトリのセットアップ手順も確認する必要がある。

## 再評価条件

- UIAP 公式 package では必要な機能や対象ボードを扱えなくなった場合。
- UIAP 側が別の Board Manager package を正式な既定へ移行した場合。
- 公式手順から外れる利点が、初学者向けの一貫性より明確に大きくなった場合。
