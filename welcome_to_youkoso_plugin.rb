# -*- coding: utf-8 -*-

Plugin.create(:welcome_to_youkoso_plugin) do
  command(:welcome_to_youkoso,
    name: 'Welcome to ようこそ plugin',
    description: 'Welcome to ようこそ plugin!\n今日も(mikutter上で)ドッタンバッタン大騒ぎ',
    condition: lambda { |opt| true },
    visible: true,
    role: :timeline
  ) do |opt|
    dialog = Gtk::Dialog.new('Welcome to ようこそ',
      $main_application_window,
      Gtk::Dialog::DESTROY_WITH_PARENT,
      [Gtk::Stock::CANCEL,Gtk::Dialog::RESPONSE_CANCEL],
      [Gtk::Stock::OK,Gtk::Dialog::RESPONSE_OK]
    )
    dialog.vbox.add(Gtk::Label.new('Welcome to ようこそ'))
    where = Gtk::Entry.new()
    where.text = 'ジャパリパーク'
    dialog.vbox.add(where)
    dialog.vbox.add(Gtk::Label.new('!	今日も'))
    why = Gtk::Entry.new()
    why.text = '(フレンズ達が)'
    dialog.vbox.add(why)
    dialog.vbox.add(Gtk::Label.new('ドッタンバッタン大騒ぎ'))
  
    dialog.show_all
    if dialog.run == Gtk::Dialog::RESPONSE_OK
      text = "Welcome to ようこそ#{where.text}!\n今日も#{why.text}ドッタンバッタン大騒ぎ"
      if Gtk::Dialog::confirm(text)
        Service.primary.post(:message => text)
      end
    end
    dialog.destroy
  end
end
