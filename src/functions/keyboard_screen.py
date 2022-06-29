from gi.repository import Gtk, Adw
from gettext import gettext as _

@Gtk.Template(resource_path='/al/getcyrst/jadegui/pages/keyboard_screen.ui')
class KeyboardScreen(Adw.Bin):
    __gtype_name__ = 'KeyboardScreen'

    event_controller = Gtk.EventControllerKey.new()
    #carousel = Gtk.Template.Child()

    ### Page and widgets for keyboard screen
   # keyboard_page = Gtk.Template.Child()
    keyboard_entry_search = Gtk.Template.Child()
    keyboard_search = Gtk.Template.Child()
    keyboard_carousel = Gtk.Template.Child()
    list_keyboard_layouts = Gtk.Template.Child()
    list_keyboard_variants = Gtk.Template.Child()
    keyboard_layouts = Gtk.Template.Child()
    keyboard_variants = Gtk.Template.Child()

    def __init__(self, window, main_carousel, next_page, application, **kwargs):
        super().__init__(**kwargs)
        self.window = window
        self.carousel = main_carousel
        self.next_page = next_page
        ### Widgets for third page (keyboard layout)
        self.keyboard_search.set_key_capture_widget(self)
        self.list_keyboard_layouts.connect("row-selected", self.selected_layout)
        self.list_keyboard_variants.connect("row-selected", self.selected_variant)

    def search_keyboards(self, *args):
        pass

    def selected_layout(self, widget, row):
        if row is not None:
            self.keyboard_carousel.scroll_to(self.keyboard_variants, True)
        else:
            print("row is none!! layout")

    def selected_variant(self, widget, row):
        if row is not None:
            print("variant selected")
        else:
            print("row is none!! variant")

