require "gtk3"
require 'jumanpp_ruby'
require 'yaml'
require "./ask"
require "./talk"

# 立ち絵画像は、「三日月アルペジオ」（http://roughsketch.en-grey.com/）さんから
# 頂いたものを元にしています。

# dictディレクトリがなければ作成する（初回限定）。
Dir.mkdir ("./dict") unless Dir.exist?("./dict") 

# ここからウィンドウの描画
# ウィンドウ透過のための設定。正直何をやっているのか理解していない。
class TranparentWindow < Gtk::Window
  def initialize
    super()
    set_app_paintable(true)
    set_title("TranparentWindow")
    set_decorated(false)
    signal_connect("delete_event") { Gtk.main_quit }
    set_double_buffered(false)
    signal_connect("screen-changed") do |widget, _old_screen| # "_"で始まる引数は、大抵それ自体は無意味だけど、エラーにならないための数合わせ。
      screen_changed(widget)
    end
       screen_changed(self)
  end

  # 透過できるか判定する。
  def screen_changed(widget)
    visual = widget.screen.rgba_visual
    if visual && widget.screen.composited?
      set_visual(visual)
      @supports_alpha = true
    else
      set_visual(widget.screen.system_visual)
      @supports_alpha = false
    end
  end
end

# ここからが実際に描画される部品
class View < TranparentWindow
  def initialize
    view = TranparentWindow.new
    view.set_default_size(280, 770)

    # ヨメ側文章表示欄
    @yome_area = Gtk::TextView.new
    @yome_area.set_size_request(500, -1)
    font = Pango::FontDescription.new('14') 
    @yome_area.override_font(font)
    @yome_area.buffer.text = 'ちょっと、今日は何してたか話しなさいよ。別にあなたのことを知りたいわけじゃないのよ。ただのヒマつぶしよ。'
    scrolled_area = Gtk::ScrolledWindow.new
    scrolled_area.set_size_request(500, -1)
    scrolled_area.set_policy(:automatic, :never)  # スクロールバー；横は自動、縦は表示しない。
    scrolled_area.add(@yome_area) 

    # オレ専用入力欄
    @ore_area = Gtk::Entry.new
    @ore_area.set_size_request(300, -1)
    @ore_area.override_font(font)
    @ore_area.buffer.text = 'ここに書きなさいよね'

    # 会話風メソッドの呼び出し。
    @switch = 0
    talks(@ore_area, @yome_area)
    @ore_area.overwrite_mode=(true)

    button = Gtk::Button.new(:label => '自爆')
    button.set_size_request(100, 20)
    button.signal_connect("clicked") {Gtk.main_quit}

    bgpxbuf = GdkPixbuf::Pixbuf.new(file: 'chara.png')
    bgimage = Gtk::Image.new(pixbuf: bgpxbuf)

    fixed = Gtk::Fixed.new
    fixed.put(bgimage, 0, 340)
    fixed.put(scrolled_area, 0,580)
    fixed.put(@ore_area, 0, 640)
    fixed.put(button, 100, 720)
    view.add(fixed)

    view.show_all
    Gtk.main
  end

  # 会話的なことをさせるメソッド
  def talks (ore, yome)
    ore.signal_connect("activate") do
      StoreWords.new.get_words (ore.text)
      case @switch
      when 0  
        yome.buffer.text = "ふーん、つまらないわね。私じゃなきゃ退屈過ぎて死ぬところだわ。"
      when 1
        begin
          yome.buffer.text = @talk.reply
        rescue
          yome.buffer.text = "その程度なわけ？もうこの話はやめましょう。"
        end
      end
      ore.text = ''     # Entryの文字を消す。
      ore.grab_focus    # ボタンをクリックしてもフォーカスをEntryに戻す。
      @switch = rand(2)
      # ５秒おいてから、次の言葉を発するようにする。
      GLib::Timeout.add(5000) do
        case @switch
        when 0
          p "case 0"
          yome.buffer.text = "それだけなの？もっと何か話しなさいよ。"
        when 1
          p "case 1"
          @talk = Talk.new
          yome.buffer.text = @talk.ask
        end
        p @switch
        false # falseにすることで、GLib::Timeoutから抜け出す。忘れると無限ループに。
      end
      end
  end
end

View.new # 実行
