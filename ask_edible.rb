require 'jumanpp_ruby'
require 'yaml'

#このファイルでは、名詞が食べられるものかどうかを聞いて、食べ物だったら
#専用の辞書ファイルに格納する。
#美味いか不味いか聞いているが、どっちを答えても、食べられるものだったら
#同じファイルに入れてしまう。

#食べ物用辞書を開く
begin
  dict_noun_edible = YAML.load_file"dict/noun_edible.yaml"
rescue
  dict_noun_edible = []
end
p dict_noun_edible

#名詞辞書を開く
dict_noun = YAML.load_file"dict/noun.yaml"
p dict_noun

#任意の名詞を拾ってきて、それが美味しいか尋ねる
word = dict_noun[rand(dict_noun.length)]

puts "ねえ、#{word}っておいしいの？"
puts "次の３つから答えて。"
puts "1 おいしいよ。2 おいしくないね。3 常考食べたり飲んだりしないだろ。"
print "> "

ans = gets.chomp

p ans

#答えが食べられるものだったら、食べ物辞書に格納して、元の辞書から抜く。
#それ以外の場合は、何もしない。
if ans == "1"
  puts "ふーん、#{word}を美味しいだなんて、いかにも庶民的ね。"
  dict_noun_edible << word
  dict_noun.delete(word)
elsif ans == "2"
  puts "ふふふ、いいこと聞いたわ。今度#{word}を作ってあげるから楽しみにしてなさい。"
  dict_noun_edible << word
  dict_noun.delete(word)
elsif ans == "3"
  puts "へえ、そうなの。でも、あなたなら#{word}でも食べられるんじゃない？"
else
  puts "ちょっと、真面目に答えなさいよ！あなたの目に#{word}突っ込んでやろうかしら！"
end

p dict_noun_edible
p dict_noun

#最後に辞書に保存する
YAML.dump(dict_noun,File.open("dict/noun.yaml", "w"))
YAML.dump(dict_noun_edible,File.open("dict/noun_edible.yaml", "w"))

