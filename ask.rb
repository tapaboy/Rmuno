require 'jumanpp_ruby'
require 'yaml'

class Dictionary
  def open
    # 初期設定
    $dict_noun = []
    $dict_noun_man = []
    $dict_noun_place = []
    $dict_noun_sahen = []
    $dict_noun_time = []
    $dict_sextet = []

    dict = [$dict_noun, $dict_noun_man, $dict_noun_place, $dict_noun_sahen, $dict_noun_time, $dict_sextet]


    dict.each do |i|
      begin
#        i = YAML.load_file"./dict/#{dict[i]}"
        i = YAML.load_file"./dict/#{i}"
        p i
      rescue
      end
    end
  end
end

class Ask
  #入力を促す
  def yome (yome_talk = "ちょっと、今日は何してたか話しなさいよ。別にあなたのことを知りたいわけじゃないのよ。ただのヒマつぶしよ。")
    return yome_talk
  end
end

class StoreWords
  Dictionary.new.open
  def get_words (input_string)
    analsis = JumanppRuby::Juman.new(force_single_path: :true)
    analsis.parse(input_string) do |i|
      #  p i
      word = [ i[0],i[5] ]
    # p word
      if word[1] == "普通名詞" then
        $dict_noun << word[0]
      elsif word[1] == "人名" then
        $dict_noun_man << word[0]
      elsif word[1] == "時相名詞" then
        $dict_noun_time << word[0]
      elsif word[1] == "地名" then
        $dict_noun_place << word[0]
      elsif word[1] == "サ変名詞" then
        $dict_noun_sahen << word[0]
      end
    end

    #単純に文章を分割
    morpheme = input_string.parse
    #p morpheme

    #6文節づつ組にして保存
    morpheme.each_index do |index|
      sextet = Array.new(morpheme[index,6])
      $dict_sextet << sextet
    end
    #重複する要素を取り除く
    $dict_sextet.uniq!

    #p dict_sextet

    #時々発生するゴミ("@")とnilを取り除く（「%」の前はスベースを入れること）
    $dict_sextet.each do |a|
    #  a.delete_if{|v| v == %!@!}
      a.delete( %!@! )
    end
    $dict_sextet.compact!

    #【確認用】
    #p dict_noun
    #p dict_noun_man
    #p dict_noun_time
    #p dict_noun_place
    #p dict_noun_sahen

    p $dict_sextet

    #辞書をファイルに保存（もしファイルがなければ作成する）
    YAML.dump($dict_noun,File.open("./dict/$dict_noun.yaml", "w"))
    YAML.dump($dict_noun_man,File.open("./dict/$dict_noun_man.yaml", "w"))
    YAML.dump($dict_noun_time,File.open("./dict/$dict_noun_time.yaml", "w"))
    YAML.dump($dict_noun_sahen,File.open("./dict/$dict_noun_sahen.yaml", "w"))
    YAML.dump($dict_noun_place,File.open("./dict/$dict_noun_place.yaml", "w"))
    YAML.dump($dict_sextet,File.open("./dict/$dict_sextet.yaml", "w"))
  end
end



=begin
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
=end
