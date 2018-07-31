import sys
import time
import obd
import json
import os
import curses


if len(sys.argv) == 1:
    connection = obd.OBD()
else:
    connection = obd.OBD(sys.argv[1])  # First arg is the device to connect to

curses.setupterm()
sys.stdout.write(curses.tigetstr("clear"))
sys.stdout.flush()

while True:
	print 'Car Information: '
	print 'Speed : ' + str(connection.query(obd.commands.SPEED).value.to("mph")) 
	print 'RPM : ' + str(connection.query(obd.commands.RPM).value)
	print 'Fuel Level: ' + str(connection.query(obd.commands.FUEL_LEVEL).value)
	print 'Engine Temp : ' + str(connection.query(obd.commands.COOLANT_TEMP).value.to("degF"))
	print '\n'
	print 'Diagonstic Information: '
	print 'Stored DTCs: ' + str(connection.query(obd.commands.GET_DTC).value)
	print 'UpTme: ' + str(connection.query(obd.commands.RUN_TIME).value)
	print '\n'
	print 'Weather Information:'
	print 'Air Temp: ' + str(connection.query(obd.commands.AMBIANT_AIR_TEMP).value.to("degF")) 
	print 'Barometric Pressure: ' + str(connection.query(obd.commands.BAROMETRIC_PRESSURE).value)
	time.sleep(5)
	curses.setupterm()
    	sys.stdout.write(curses.tigetstr("clear"))
    	sys.stdout.flush()

