require 'jumanpp_ruby'
require 'yaml'

#このファイルでは、行動にまつわる会話をします。

#行動用辞書を開く
dict_noun_sahen = YAML.load_file"dict/noun_sahen.yaml"
p dict_noun_sahen

#任意の名詞を拾ってきて話し出す。
word = dict_noun_sahen[rand(dict_noun_sahen.length)]

puts "今度の日曜日は#{word}するんだ。うらやましいでしょ？"
puts "どうせあなたは一人寂しく過ごすんでしょうから、#{word}させてあげてもいいけど？"
puts "1 よろしく。2 別にいいよ。3 どうしようかな。"
print "> "

ans = gets.chomp

p ans

if ans == "1"
  puts "やったあ！・・・じゃなくて、仕方ないわね。どうしてもって言うなら#{word}させてあげるわ。"
elsif ans == "2"
  puts "そんな・・・　もう絶対#{word}に誘ってあげないんだから！"
elsif ans == "3"
  puts "なにそれ？決められない男なんてサイテー。"
else
  puts "ちょっと、真面目に答えなさいよ！"
end
