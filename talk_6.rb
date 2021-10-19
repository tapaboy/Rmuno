require 'jumanpp_ruby'
require 'yaml'

#辞書ファイルを読み込む。
dict_pair = YAML.load_file"dict/pair.yaml"
p dict_pair

#名詞辞書を開く
dict_noun = YAML.load_file"dict/noun.yaml"
p dict_noun

#任意の名詞を拾ってきて、会話を始める。
word = dict_noun[rand(dict_noun.length)]

puts "ねえ、#{word}について語りましょう。"

phrase = [word]
next_phrase = []

until word == "EOS"
  next_phrase = dict_pair.shuffle.assoc(word)
  phrase.concat (next_phrase[1..-1])
  word = next_phrase[-1]
end

phrase.delete_at -1

puts phrase.join

###
###無限ループしてしまう
###


