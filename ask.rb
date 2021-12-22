require 'jumanpp_ruby'
require 'yaml'

class Ask
  #入力を促す
  def yome (yome_talk = "ちょっと、今日は何してたか話しなさいよ。別にあなたのことを知りたいわけじゃないのよ。ただのヒマつぶしよ。")
    return yome_talk
  end
end

class StoreWords
  def get_words (input_string)
    # 辞書用変数を作成する。
    $dict_noun = []
    $dict_noun_man = []
    $dict_noun_place = []
    $dict_noun_sahen = []
    $dict_noun_time = []
    $dict_sextet = []

    # 辞書ファイルを読み込む。まだ辞書ファイルがなければ何もしない。
    begin
      $dict_noun = YAML.load_file("./dict/dict_noun.yaml")
      $dict_noun_man = YAML.load_file("./dict/dict_noun_man.yaml")
      $dict_noun_place = YAML.load_file("./dict/dict_noun_place.yaml")
      $dict_noun_sahen = YAML.load_file("./dict/dict_noun_sahen.yaml")
      $dict_noun_time = YAML.load_file("./dict/dict_noun_time.yaml")
      $dict_sextet = YAML.load_file("./dict/dict_sextet.yaml")
    rescue
    end
  
    # 入力を解析する。
    analsis = JumanppRuby::Juman.new(force_single_path: :true)
    analsis.parse(input_string) do |i|
      word = [ i[0],i[5] ]
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
    $dict_noun.uniq!
    $dict_noun_man.uniq!
    $dict_noun_time.uniq!
    $dict_noun_place.uniq!
    $dict_noun_sahen.uniq!
    $dict_sextet.uniq!

    #時々発生するゴミ("@")とnilを取り除く（「%」の前はスベースを入れること）
    $dict_sextet.each do |a|
      a.delete( %!@! )
    end
    $dict_sextet.compact!

    #【確認用】
    #p $dict_noun
    #p $dict_noun_man
    #p $dict_noun_time
    #p $dict_noun_place
    #p $dict_noun_sahen
    #p $dict_sextet

    #辞書をファイルに保存（もしファイルがなければ作成する）。
    file_noun = File.open("./dict/dict_noun.yaml", "w")
    YAML.dump($dict_noun,file_noun)
    file_noun.close
    file_noun_man = File.open("./dict/dict_noun_man.yaml", "w")
    YAML.dump($dict_noun_man,file_noun_man)
    file_noun_man.close
    file_noun_time = File.open("./dict/dict_noun_time.yaml", "w")
    YAML.dump($dict_noun_time,file_noun_time)
    file_noun_time.close
    file_noun_sahen = File.open("./dict/dict_noun_sahen.yaml", "w")
    YAML.dump($dict_noun_sahen,file_noun_sahen)
    file_noun_sahen.close
    file_noun_place = File.open("./dict/dict_noun_place.yaml", "w")
    YAML.dump($dict_noun_place,file_noun_place)
    file_noun_place.close
    file_sextet = File.open("./dict/dict_sextet.yaml", "w")
    YAML.dump($dict_sextet,file_sextet)
    file_sextet.close
  end
end