/* window.js
 *
 * Copyright 2022 crystal linux
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';
import Adw from 'gi://Adw';

export const JadeGuiWindow = GObject.registerClass({
    GTypeName: 'JadeGuiWindow',
    Template: 'resource:///al/getcryst/jadegui/window.ui',
    InternalChildren: ['label', 'quitButton', 'nextButton', 'crystal-logo'],
}, class JadeGuiWindow extends Gtk.ApplicationWindow {
    _init(application) {
        super._init({ application });
        this._quitButton.connect('clicked', () => {
            confirm_quit();
        });
    }
});

function confirm_quit() {
    const quitDialog = new Gtk.MessageDialog({
    text: "Do you want to try\nCrystal without installing?",
    transient_for: JadeGuiWindow,
    modal: true,
    buttons: Gtk.ButtonsType.Ok,
  });

  quitDialog.connect("response", () => {
    quitDialog.close();
  });

  quitDialog.present();

}

