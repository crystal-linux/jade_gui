# window.py

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

from gi.repository import Gtk
from gi.repository import Gdk
from .widgets.timezone import TimezoneEntry
from .widgets.layout import KeyboardLayout
from .widgets.variant import KeyboardVariant
from .widgets.desktop import DesktopEntry
from .functions.keyboard_screen import KeyboardScreen
from .functions.timezone_screen import TimezoneScreen
from .functions.user_screen import UserScreen
from .functions.desktop_screen import DesktopScreen

@Gtk.Template(resource_path='/al/getcryst/jadegui/window.ui')
class JadeGuiWindow(Gtk.ApplicationWindow):
    __gtype_name__ = 'JadeGuiWindow'

    event_controller = Gtk.EventControllerKey.new()
    carousel = Gtk.Template.Child()

    ### Page and widgets on welcome screen
    welcome_page = Gtk.Template.Child()
  #  quit_button = Gtk.Template.Child()
    next_button = Gtk.Template.Child()



    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.desktop_screen = DesktopScreen(window=self, main_carousel=self.carousel, next_page=None, **kwargs)
        self.user_screen = UserScreen(window=self, main_carousel=self.carousel, next_page=self.desktop_screen, **kwargs)
        self.keyboard_screen = KeyboardScreen(window=self, main_carousel=self.carousel, next_page=self.user_screen, **kwargs)
        self.timezone_screen = TimezoneScreen(window=self, main_carousel=self.carousel, next_page=self.keyboard_screen, **kwargs)
        self.carousel.append(self.timezone_screen)
        self.carousel.append(self.keyboard_screen)
        self.carousel.append(self.user_screen)
        self.carousel.append(self.desktop_screen)
        ### Widgets for first page (welcome screen)
        #self.quit_button.connect("clicked", self.confirmQuit)
        self.next_button.connect("clicked", self.nextPage)
        ### ---------

        ### Test timezones
        timezone_test = TimezoneEntry(window=self, location="Europe", region="Berlin", timezone="CEST UTC+2", locale="en_US.UTF-8", **kwargs)
        timezone_test_two = TimezoneEntry(window=self, location="Europe", region="London", timezone="BST UTC+1", locale="en_US.UTF-8", **kwargs)
        timezone_test_three = TimezoneEntry(window=self, location="America", region="Chihuahua", timezone="MDT UTC-6", locale="en_MX.UTF-8", **kwargs)
        self.timezone_screen.list_timezones.append(timezone_test)
        self.timezone_screen.list_timezones.append(timezone_test_two)
        self.timezone_screen.list_timezones.append(timezone_test_three)
        ### ---------

        ### Test layouts
        layout_test = KeyboardLayout(window=self, country="Germany", country_shorthand="DE", **kwargs)
        layout_test_two = KeyboardLayout(window=self, country="United Kingdom", country_shorthand="GB", **kwargs)
        layout_test_three = KeyboardLayout(window=self, country="United States", country_shorthand="US", **kwargs)
        self.keyboard_screen.list_keyboard_layouts.append(layout_test)
        self.keyboard_screen.list_keyboard_layouts.append(layout_test_two)
        self.keyboard_screen.list_keyboard_layouts.append(layout_test_three)
        ### ---------

        ### Test variants
        variant_test = KeyboardVariant(window=self, variant="Colemak", country="United Kingdom", country_shorthand="GB", **kwargs)
        variant_test_two = KeyboardVariant(window=self, variant="QWERTY", country="Germany", country_shorthand="DE", **kwargs)
        variant_test_three = KeyboardVariant(window=self, variant="QWERTZ", country="United States", country_shorthand="US", **kwargs)
        self.keyboard_screen.list_keyboard_variants.append(variant_test)
        self.keyboard_screen.list_keyboard_variants.append(variant_test_two)
        self.keyboard_screen.list_keyboard_variants.append(variant_test_three)
        ### ---------

        ### Test desktops
        desktop_test = DesktopEntry(window=self, desktop="GNOME", button_group=None, **kwargs)
        desktop_test_two = DesktopEntry(window=self, desktop="Onyx", button_group=desktop_test.select_button, **kwargs)
        desktop_test_three = DesktopEntry(window=self, desktop="KDE", button_group=desktop_test.select_button, **kwargs)
        desktop_test.select_button.set_active(True)
        self.desktop_screen.list_desktops.append(desktop_test)
        self.desktop_screen.list_desktops.append(desktop_test_two)
        self.desktop_screen.list_desktops.append(desktop_test_three)
        ### ---------

    # TODO: offload functions to seperate files/classes

    def nextPage(self, idk):
        self.carousel.scroll_to(self.timezone_screen, True)

    def confirmQuit(self, idk):

        def handle_response(_widget, response_id):
            if response_id == Gtk.ResponseType.YES:
                _widget.destroy()
                self.destroy()
            elif response_id == Gtk.ResponseType.NO:
                _widget.destroy()

        dialog = Gtk.MessageDialog(
            transient_for=self,
            modal=True,
            parent=self,
            text=_("Do you want to try\nCrystal without installing?"),
            buttons=Gtk.ButtonsType.YES_NO
        )
        dialog.connect("response", handle_response)
        dialog.present()





class AboutDialog(Gtk.AboutDialog):

    def __init__(self, parent):
        Gtk.AboutDialog.__init__(self)
        self.props.program_name = 'jade_gui'
        self.props.version = "0.1.0"
        self.props.authors = ['user']
        self.props.copyright = '2022 user'
        self.props.logo_icon_name = 'al.getcryst.jadegui'
        self.props.modal = True
        self.set_transient_for(parent)
