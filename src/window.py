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
from .widgets.disk import DiskEntry
from .functions.keyboard_screen import KeyboardScreen
from .functions.timezone_screen import TimezoneScreen
from .functions.user_screen import UserScreen
from .functions.desktop_screen import DesktopScreen
from .functions.misc_screen import MiscScreen
from .functions.partition_screen import PartitionScreen
from .functions.summary_screen import SummaryScreen
from .functions.install_screen import InstallScreen
from .functions.finished_screen import FinishedScreen
from .locales.locales_list import locations
from .keymaps import keymaps

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
        self.finished_screen = FinishedScreen(window=self, **kwargs)
        self.installer_screen = InstallScreen(window=self, main_carousel=self.carousel, next_page=self.finished_screen, **kwargs)
        self.summary_screen = SummaryScreen(window=self, main_carousel=self.carousel, next_page=self.installer_screen, **kwargs)
        self.partition_screen = PartitionScreen(window=self, main_carousel=self.carousel, next_page=self.summary_screen, **kwargs)
        self.misc_screen = MiscScreen(window=self, main_carousel=self.carousel, next_page=self.partition_screen, **kwargs)
        self.desktop_screen = DesktopScreen(window=self, main_carousel=self.carousel, next_page=self.misc_screen, **kwargs)
        self.user_screen = UserScreen(window=self, main_carousel=self.carousel, next_page=self.desktop_screen, **kwargs)
        self.keyboard_screen = KeyboardScreen(window=self, main_carousel=self.carousel, next_page=self.user_screen, **kwargs)
        self.timezone_screen = TimezoneScreen(window=self, main_carousel=self.carousel, next_page=self.keyboard_screen, **kwargs)
        self.carousel.append(self.timezone_screen)
        self.carousel.append(self.keyboard_screen)
        self.carousel.append(self.user_screen)
        self.carousel.append(self.desktop_screen)
        self.carousel.append(self.misc_screen)
        self.carousel.append(self.partition_screen)
        self.carousel.append(self.summary_screen)
        self.carousel.append(self.installer_screen)
        self.carousel.append(self.finished_screen)
        ### Widgets for first page (welcome screen)
        #self.quit_button.connect("clicked", self.confirmQuit)
        self.next_button.connect("clicked", self.nextPage)
        ### ---------

        ### Test timezones
        for i in locations:
            for locale in i:
                print(locale.region)
                print(locale.location)
                print(locale.locales)
                self.timezone_screen.list_timezones.append(TimezoneEntry(window=self, region=locale.region, location=locale.location, locale=locale.locales, **kwargs))
        ### ---------

        ### Test layouts
        for keymap in keymaps:
            print(keymap.layout)
            print(keymap.backend_layout)
            self.keyboard_screen.list_keyboard_layouts.append(KeyboardLayout(window=self, country=keymap.layout, country_shorthand=keymap.backend_layout, variants=keymap.variant, **kwargs))
        ### ---------

        ### Test variants

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

        ### Test partitions
        partition_test = DiskEntry(window=self, disk="/dev/sda", disk_size="2000gb", button_group=None, **kwargs)
        partition_test_two = DiskEntry(window=self, disk="/dev/nvme0n1", disk_size="100mb (morbillion bytes)", button_group=partition_test.select_button, **kwargs)
        partition_test_three = DiskEntry(window=self, disk="/dev/whatotherdisklabelsarethere", disk_size="no", button_group=partition_test.select_button, **kwargs)
        self.partition_screen.partition_list.append(partition_test)
        self.partition_screen.partition_list.append(partition_test_two)
        self.partition_screen.partition_list.append(partition_test_three)
        ### ---------

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
