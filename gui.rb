require "gtk3"
require 'jumanpp_ruby'
require 'yaml'



class TranparentWindow < Gtk::Window
  def initialize
    super()

    set_app_paintable(true)
    set_title("TranparentWindow")
    set_decorated(false)
    signal_connect("delete_event") { Gtk.main_quit }
    set_double_buffered(false)

    signal_connect("screen-changed") do |widget, _old_screen|
      screen_changed(widget)
    end
   
    screen_changed(self)
  end

  # 透過できるか判定。
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

class View < TranparentWindow
  def initialize
    @view = TranparentWindow.new
    @view.set_default_size(300, 300)
    @text_area = Gtk::TextView.new
    @text_area.set_size_request(100, 30)
    @text_area.buffer.text = '我はひよこなり！汝、我の前にひれ伏せ'

    scrolled_area = Gtk::ScrolledWindow.new
    scrolled_area.set_size_request(100, -1)
    scrolled_area.set_policy(:automatic, :never)  # スクロールバー；横は自動、縦は表示しない。
    scrolled_area.add(@text_area) 

    def put_text(entry, textview)
      textview.buffer.text = "#{entry.text}\n"  # Entryの内容をTextVeiwのテキストに表示
      entry.text = ''     # Entryの文字を消す
      entry.grab_focus    # ボタンをクリックしてもフォーカスをEntryに戻す
    end

    entry_area = Gtk::Entry.new
    entry_area.set_size_request(100, -1)
    entry_area.signal_connect("activate") do
      put_text(entry_area, @text_area)
    end

    entry_area.overwrite_mode=(true)
    box = Gtk::Box.new(:horizontal)
    label = Gtk::Label.new('何か言ってみ')
    box.pack_start(label, :expand => false, :fill => false, :padding => 0)
    box.pack_start(entry_area, :expand => false, :fill => false, :padding => 0)

    button = Gtk::Button.new(:label => '自爆')
    button.set_size_request(100, 20)
    button.signal_connect("clicked") {Gtk.main_quit}

    bgpxbuf = GdkPixbuf::Pixbuf.new(file: 'bg.png')
    bgimage = Gtk::Image.new(pixbuf: bgpxbuf)

    fixed = Gtk::Fixed.new
    fixed.put(bgimage, 0, 0)
    fixed.put(scrolled_area, 100,200)
    fixed.put(box, 50,235)
    fixed.put(button, 100, 270)
    @view.add(fixed)

    @view.show_all
    Gtk.main
  end

  def yome (yome_talk)
    @text_area.buffer.text = yome_talk
    Gtk.main_quit
    @view.show_all
    Gtk.main
    p yome_talk
  end
end