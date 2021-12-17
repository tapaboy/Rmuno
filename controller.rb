require 'jumanpp_ruby'
require 'yaml'
require "gtk3"
require "./gui"
require "./ask"

# 初期設定
dict_noun = []
dict_noun_man = []
dict_noun_place = []
dict_noun_sahen = []
dict_noun_time = []
dict_sextet = []

dict = [dict_noun, dict_noun_man, dict_noun_place, dict_noun_sahen, dict_noun_time, dict_sextet]

dict.each do |i|
  begin
    i = YAML.load_file"./dict/#{dict[i]}"
  rescue
  end
end

# ウィンドウを表示する。

yome = 'めんどくさい'

view = View.new (yome)


#辞書をファイルに保存（もしファイルがなければ作成する）
YAML.dump(dict_noun,File.open("./dict/dict_noun.yaml", "w"))
YAML.dump(dict_noun_man,File.open("./dict/dict_noun_man.yaml", "w"))
YAML.dump(dict_noun_time,File.open("./dict/dict_noun_time.yaml", "w"))
YAML.dump(dict_noun_sahen,File.open("./dict/dict_noun_sahen.yaml", "w"))
YAML.dump(dict_noun_place,File.open("./dict/dict_noun_place.yaml", "w"))
YAML.dump(dict_sextet,File.open("./dict/dict_sextet.yaml", "w"))

