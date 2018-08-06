#!/usr/bin/env python
# Usage: obd_test.py DEVICE
# Example: obd_test.py /dev/ttyUSB0
# Prints supported OBD commands to the console, along values.

import sys
import obd

if len(sys.argv) == 1:
    connection = obd.OBD()
else:
    connection = obd.OBD(sys.argv[1])  # First arg is the device to connect to

print("Supported commands")
print("------------------")

command_names = []
for command in connection.supported_commands:
    try:
        print("{}: {}".format(command.name, connection.query(command)))
        command_names.append(command.name)
    except NameError:
        pass
