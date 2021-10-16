require 'jumanpp_ruby'
require 'yaml'

#辞書ファイルがあれば読み込む。
begin
  dict_pair = YAML.load_file"dict/pair.yaml"
rescue
  dict_pair = []
end

p dict_pair

#入力を促す
puts "ちょっと、今日は何してたか話しなさいよ。別にあなたのことを知りたいわけじゃないのよ。ただのヒマつぶしよ。"
print "言葉を入力してください>"
#入力を変数に格納
input_string = gets.chomp

puts "ふーん、無駄に生きてるのね。聞いて損したわ。"

#p input_string.parse

morpheme = input_string.parse

#p morpheme

#２文節づつ組にして保存
morpheme.each_index do |index|
  pair = Array.new([morpheme[index],morpheme[index+1]])
  dict_pair << pair
end


#重複する要素を取り除く
dict_pair.uniq!

YAML.dump(dict_pair,File.open("dict/pair.yaml", "w"))
