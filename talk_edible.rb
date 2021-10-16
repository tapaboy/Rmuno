require 'jumanpp_ruby'
require 'yaml'

#このファイルでは、食べ物にまつわる会話をします。

#食べ物用辞書を開く
dict_noun_edible = YAML.load_file"dict/noun_edible.yaml"
p dict_noun_edible

#任意の名詞を拾ってきて話し出す。
word = dict_noun_edible[rand(dict_noun_edible.length)]

puts "ちょっと#{word}を作ってみたんだけど、当然あなたも食べるわよね？"
puts "別にあなたのために作ったわけじゃないのよ。"
puts "材料が安かったからちょっと買いすぎただけなんだから。"
puts "ねえ、私が作った#{word}はおいしかった？"
puts "1 おいしかった。2 おいしくなかった。3 普通だね。"
print "> "

ans = gets.chomp

p ans

if ans == "1"
  puts "ふう、よかった・・・じゃなくて、私が作る#{word}はおいしいに決まっているでしょ。"
elsif ans == "2"
  puts "え？・・・　もう絶対#{word}を作ってあげないんだから！"
elsif ans == "3"
  puts "なにそれ？普通とかある意味一番失礼だわ。"
else
  puts "ちょっと、真面目に答えなさいよ！もう、何も作ってあげないわよ！"
end
