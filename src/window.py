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
import time

@Gtk.Template(resource_path='/al/getcyrst/jadegui/window.ui')
class JadeGuiWindow(Gtk.ApplicationWindow):
    __gtype_name__ = 'JadeGuiWindow'

    carousel = Gtk.Template.Child()

    ### Page and widgets on welcome screen
    welcome_page = Gtk.Template.Child()
    quit_button = Gtk.Template.Child()
    next_button = Gtk.Template.Child()

    ### Page and widgets on timezone screen
    timezone_page = Gtk.Template.Child()
    list_timezones = Gtk.Template.Child()
    entry_search = Gtk.Template.Child()
    timezone_search = Gtk.Template.Child()
    event_controller = Gtk.EventControllerKey.new()

    def __init__(self, **kwargs):
        super().__init__(**kwargs)


        ### Widgets for first page (welcome screen)
        self.quit_button.connect("clicked", self.confirmQuit)
        self.next_button.connect("clicked", self.nextPage)
        ### ---------

        ### Widgets for second page (timezone selection)
        self.event_controller.connect("key-released", self.search_timezones)
        self.entry_search.add_controller(self.event_controller)
        self.timezone_search.set_key_capture_widget(self)
        self.list_timezones.connect("row-selected", self.selected_timezone)
        ### ---------

        ### Test timezones
        timezone_test = TimezoneEntry(window=self, location="Europe", region="Berlin", timezone="CEST UTC+2", locale="en_US.UTF-8", **kwargs)
        timezone_test_two = TimezoneEntry(window=self, location="Europe", region="London", timezone="BST UTC+1", locale="en_US.UTF-8", **kwargs)
        timezone_test_three = TimezoneEntry(window=self, location="America", region="Chihuahua", timezone="MDT UTC-6", locale="en_MX.UTF-8", **kwargs)
        self.list_timezones.append(timezone_test)
        self.list_timezones.append(timezone_test_two)
        self.list_timezones.append(timezone_test_three)
        ### ---------

    # TODO: offload functions to seperate files/classes

    def nextPage(self, idk):
        self.carousel.scroll_to(self.timezone_page, True)

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

    def selected_timezone(self, widget, row):
        if row is not None:
            print(row.get_title())
        else:
            print("row is none!!")

    def search_timezones(self, *args):
        terms = self.entry_search.get_text()
        self.list_timezones.set_filter_func(self.filter_timezones, terms)

    @staticmethod
    def filter_timezones(row, terms=None):
        text = row.get_title()
        text = text.lower() + row.get_subtitle().lower()
        if terms.lower() in text:
            return True
        return False

class AboutDialog(Gtk.AboutDialog):

    def __init__(self, parent):
        Gtk.AboutDialog.__init__(self)
        self.props.program_name = 'jade_gui'
        self.props.version = "0.1.0"
        self.props.authors = ['user']
        self.props.copyright = '2022 user'
        self.props.logo_icon_name = 'al.getcyrst.jadegui'
        self.props.modal = True
        self.set_transient_for(parent)
