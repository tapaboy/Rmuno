require 'jumanpp_ruby'
require 'yaml'

#辞書ファイルを読み込む。
dict_sextet = YAML.load_file"dict/sextet.yaml"
p dict_sextet

#名詞辞書を開く
dict_noun = YAML.load_file"dict/noun.yaml"
p dict_noun

#任意の名詞を拾ってきて、会話を始める。
word = dict_noun[rand(dict_noun.length)]

puts "ねえ、#{word}について語りましょう。"

phrase = [word]
next_phrase = []

until word == "EOS"
  next_phrase = dict_sextet.shuffle.assoc(word)
  if next_phrase.any?("。")
    next_phrase.pop(next_phrase.reverse.index("。"))
  end
  phrase.concat (next_phrase[1..-1])
  if phrase.last == "。"
    break
  end
  word = next_phrase.last
end

phrase.delete("EOS")

puts phrase.join



