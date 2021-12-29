require 'jumanpp_ruby'
require 'yaml'

class Talk
  def initialize
    if FileTest.exist? ("./dict/dict_noun.yaml") && ("./dict/dict_sextet.yaml")
      # 辞書用変数を作成する。
      $dict_noun = []
      $dict_sextet = []

      # 辞書ファイルを読み込む。まだ辞書ファイルがなければ何もしない。
      begin
        $dict_noun = YAML.load_file("./dict/dict_noun.yaml")
        $dict_sextet = YAML.load_file("./dict/dict_sextet.yaml")
      rescue
      end
  #    p $dict_sextet
  #    p $dict_noun

      #任意の名詞を拾ってきて、会話を始める。
      @word = $dict_noun[rand($dict_noun.length)]
    else
      p "辞書ファイルが存在しません。"  
    end
  end


  def ask
    return "ねえ、#{@word}について語りあいましょう。"
  end

  def reply
    if FileTest.exist? ("./dict/dict_noun.yaml") && ("./dict/dict_sextet.yaml")
      phrase = [@word]
      next_phrase = []

      until @word == "EOS"
        next_phrase = $dict_sextet.shuffle.assoc(@word)
        begin # たまに「undefined method `[]' for nil:NilClass」というエラーがでるので。
          if next_phrase[1] == "EOS"
            phrase[0] = "#{@word}は#{@word}よ。"
            break
          end
        rescue
          phrase[0] = "#{@word}は#{@word}よ。"
#          next_phrase = "EOS"
          break
        end
        # 続く言葉の配列に「。」があったら、「。」よりあとを切り捨てる。
        if next_phrase.any?("。")
          next_phrase.pop(next_phrase.reverse.index("。"))
        end
        # 文字列をくっつける。
        phrase.concat (next_phrase[1..-1])
        if phrase.last == "。"
          break
        end
        @word = next_phrase.last
      end

      phrase.delete("EOS")

      return "やっぱりあなたの見識は低いわね。いいこと、#{phrase.join}"
    else
      p "辞書ファイルが存在しません。"  
    end
  end
end

#talk = Talk.new
#puts talk.ask
#puts talk.reply


