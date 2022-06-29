from gi.repository import Gtk, Adw
from gettext import gettext as _

@Gtk.Template(resource_path='/al/getcyrst/jadegui/pages/timezone_screen.ui')
class TimezoneScreen(Adw.Bin):
    __gtype_name__ = 'TimezoneScreen'

    event_controller = Gtk.EventControllerKey.new()
    #carousel = Gtk.Template.Child()

    ### Page and widgets on timezone screen
    #timezone_page = Gtk.Template.Child()
    list_timezones = Gtk.Template.Child()
    timezone_entry_search = Gtk.Template.Child()
    timezone_search = Gtk.Template.Child()

    def __init__(self, window, main_carousel, next_page, application, **kwargs):
        super().__init__(**kwargs)
        self.window = window
        self.carousel = main_carousel
        self.next_page = next_page


        ### Widgets for second page (timezone selection)
        self.event_controller.connect("key-released", self.search_timezones)
        self.timezone_entry_search.add_controller(self.event_controller)
        self.timezone_search.set_key_capture_widget(self)
        self.list_timezones.connect("row-selected", self.selected_timezone)
        ### ---------

    def selected_timezone(self, widget, row):
            if row is not None:
                print(row.get_title())
                self.carousel.scroll_to(self.next_page, True)
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
