# exec.py
#
# Copyright 2022 axtlos
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
#
# SPDX-License-Identifier: GPL-3.0-only

import subprocess, math
def get_disks():
    command=subprocess.run(["bash", "-c", "bash -- /app/share/jade_gui/jade_gui/scripts/getDisks.sh"], capture_output=True)
    disks=command.stdout.decode('utf-8')[:-1].split('\n')
    return disks

def get_disk_size(disk: str):
    command=subprocess.run(["bash", "-c", "bash -- /app/share/jade_gui/jade_gui/scripts/getDiskSize.sh "+disk], capture_output=True)
    size=command.stdout.decode('utf-8').strip('\n')
    print(disk+":"+size)
    return str(math.floor(int(size)/1000**3))+" GB"
