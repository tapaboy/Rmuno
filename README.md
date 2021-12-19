# Rmuno
心機一転して、Rubyを使った人工無脳っぽいものを一から作ってます。
なお、今のところ、取り込んだ文章から、名詞の辞書を作るところまでしかできていません。
次は、文章っぽいものを作るところまでやってみます。

作成環境（xubuntu21.04→21.10、Ruby2.7、GTK3）

## 使う前に
今回は形態素解析のためにJUMAN++を使ってますので、あらかじめインストールしておいてください。
また、
　gem gtk3
でRubyでGTK3を使うためのライブラリをインストールしておいてください。
インストール方法及びRubyで使えるようにする方法は、すみませんがググるなどして調べてください。

## 使い方
プログラムの入っているディレクトリに移動します。
 ruby gui.rb
を実行します。

## 既知の問題
-まれに辞書ファイル(YAMLファイル）が壊れることがあります。
-辞書ファイルに入力した覚えのない記号が含まれることがあります（例えば改行のある文章をそのままコピペすると発生します。）。

## その他
画像は、「三日月アルペジオ」（ http://roughsketch.en-grey.com/ ）さんから頂いたものを元にしています。
