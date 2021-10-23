require 'jumanpp_ruby'
require 'yaml'

#辞書ファイルがあれば読み込む。将来的には、ループ文にしたい。
begin
  dict_noun = YAML.load_file"dict/noun.yaml"
rescue
  dict_noun = []
end
begin
  dict_noun_man = YAML.load_file"dict/noun_man.yaml"
rescue
  dict_noun_man = []
end
begin
  dict_noun_place = YAML.load_file"dict/noun_place.yaml"
rescue
  dict_noun_place = []
end
begin
  dict_noun_sahen = YAML.load_file"dict/noun_sahen.yaml"
rescue
  dict_noun_sahen = []
end
begin
  dict_noun_time = YAML.load_file"dict/noun_time.yaml"
rescue
  dict_noun_time = []
end

begin
  dict_sextet = YAML.load_file"dict/sextet.yaml"
rescue
  dict_sextet = []
end


#p dict_noun
#p dict_noun_man
#p dict_noun_place
#p dict_noun_sahen
#p dict_noun_time
#p dict_sextet

#入力を促す
puts "ちょっと、今日は何してたか話しなさいよ。別にあなたのことを知りたいわけじゃないのよ。ただのヒマつぶしよ。"
print "言葉を入力してください>"
#入力を変数に格納
input_string = gets.chomp

puts "ふーん、無駄に生きてるのね。聞いて損したわ。"

analsis = JumanppRuby::Juman.new(force_single_path: :true)
#analsis.parse('親方、1984年4月の日曜日に空から女の子が降ってきた！彼女の名は郁恵。馬鹿は来年言え。敏夫。') do |i|
analsis.parse(input_string) do |i|
  #  p i
  word = [ i[0],i[5] ]
  p word
  if word[1] == "普通名詞" then
    dict_noun << word[0]
  elsif word[1] == "人名" then
    dict_noun_man << word[0]
  elsif word[1] == "時相名詞" then
    dict_noun_time << word[0]
  elsif word[1] == "地名" then
    dict_noun_place << word[0]
  elsif word[1] == "サ変名詞" then
    dict_noun_sahen << word[0]
  end
end

#単純に文章を分割
morpheme = input_string.parse
#p morpheme

#6文節づつ組にして保存
morpheme.each_index do |index|
  sextet = Array.new(morpheme[index,6])
  dict_sextet << sextet
end
#重複する要素を取り除く
dict_sextet.uniq!

p dict_sextet

#時々発生するゴミ("@")とnilを取り除く（「%」の前はスベースを入れること）
dict_sextet.each do |a|
#  a.delete_if{|v| v == %!@!}
  a.delete( %!@! )
end
dict_sextet.compact!

#【確認用】
#p dict_noun
#p dict_noun_man
#p dict_noun_time
#p dict_noun_place
#p dict_noun_sahen

p dict_sextet

#辞書をファイルに保存（もしファイルがなければ作成する）
YAML.dump(dict_noun,File.open("dict/noun.yaml", "w"))
YAML.dump(dict_noun_man,File.open("dict/noun_man.yaml", "w"))
YAML.dump(dict_noun_time,File.open("dict/noun_time.yaml", "w"))
YAML.dump(dict_noun_sahen,File.open("dict/noun_sahen.yaml", "w"))
YAML.dump(dict_noun_place,File.open("dict/noun_place.yaml", "w"))

YAML.dump(dict_sextet,File.open("dict/sextet.yaml", "w"))
