# keyboard_Screen.py

#
# Copyright 2022 user

#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


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
            self.carousel.scroll_to(self.next_page, True)
        else:
            print("row is none!! variant")

