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

string = word

#8.times do
until word == "EOS"
  #要素がnilだとエラーになるので、そのときは終わらせる
  begin
    word = dict_pair.shuffle.assoc(word)[-1]
  rescue
    puts "やっぱりバカバカしいからやめましょう"
    exit
  end
  if word == "EOS"
    break
  else
    string += word
  end
end
p string
