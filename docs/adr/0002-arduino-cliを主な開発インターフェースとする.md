# 0002: Arduino CLI を主な開発インターフェースとする

## 状態

採用

## 背景

Arduino IDE は UIAPduino の公式な開発手段として分かりやすい一方、`hello-uiap` では Linux 上で
コマンドとして再現できる開発フローも学習対象にしたい。

Arduino CLI では Board Manager、library、Verify、Upload など Arduino IDE の主要操作を
コマンドとして実行できる。また、エディタを限定せず、実際に実行する FQBN やコマンドを確認しやすい。

一方で、Arduino の build / upload 処理そのものを独自 script で再実装すると、Arduino 標準から
離れ、保守対象が増える。

この判断は、`scripts/uiapduino` を Arduino CLI の薄いラッパーとして導入した既存方針を遡及して
記録する。

## 決定

このリポジトリでは Arduino CLI を主な説明・操作インターフェースとする。

`scripts/uiapduino` は Arduino CLI の薄いラッパーとし、次のような操作性の補助だけを担当する。

- UIAPduino board support のセットアップ。
- sketch の選択・作成。
- Verify。
- Upload。

compile、link、board package 管理、upload などの実処理は `arduino-cli` に任せる。

Arduino IDE も利用可能な選択肢として残し、IDE と CLI で可能な限り同じ公式 UIAPduino package を
使用する。

## 理由

- コマンドが明示され、学習内容を再現しやすい。
- Neovim など任意のエディタと組み合わせられる。
- Arduino の標準 build system をそのまま利用できる。
- helper script の責務を小さく保てる。
- Arduino IDE を使う場合との概念差を最小限にできる。

## 影響

- ドキュメントの happy path は Arduino CLI を中心に記述する。
- Arduino IDE 固有の画面操作は公式ドキュメントへの参照を優先する。
- `scripts/uiapduino` は便利機能を追加しても、独自 build system にはしない。
- Arduino CLI の標準ディレクトリや Board Manager の仕組みを前提とする。

## 再評価条件

- Arduino CLI では UIAPduino の公式開発手順を再現できなくなった場合。
- helper script が Arduino CLI の薄いラッパーでは済まないほど複雑になった場合。
- Arduino IDE を主経路に戻すことで、学習体験や保守性が明確に改善する場合。
