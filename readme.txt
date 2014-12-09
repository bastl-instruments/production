Uploading a hex file into Bastl Instruments product

There are three ways of uploading the hex file to the device
1-via dedicated upload.command file (works only on mac)
2-via dedicated utility app
3-via command line (for mac and linux you will find the line in the upload.command file)

What you need to have installed to be able to use the upload.command file
1-driver 	- FTDi driver if you are using FTDi based usb converter
		- other arduino dedicated usb board (atmel based)
	-the driver 
2-avrdude and arduino - the easiest way to get this done is to install arduino on your computer. go to arduino.cc


#################
Using upload.command method (works on mac only)

after downloading first run setup.command file - this sets the serial port . 
select one that looks similar to this: /dev/tty.usbserial-AD01SV3E
write its number and hit enter
close the setup.command window

run upload.command
write number of desired code to upload and hit enter
-you should get confirmation of correct upload in the window
-hit enter to repeat

automatic updated of the .hex files
there is update.command file to make automatic updates of the whole hex file folder.
this should get you the latest versions of the hex files
to be able to do this download and install github app -> register and than go to 
add repository -> clone 
and find the bastl/production repository
than if you run the update.command in such folder it should get you the latest updates


ATTINY85
for uploading the firmware to attiny 85 on MIDI Bastl go to attiny folder and run upload.command
you need to have hardware for uploading to attiny prepared as described here
http://highlowtech.org/?p=1695


+ installed the attiny hardware in arduino
##################

##################
using dedicated app
get the app for your system
- mac & linux: HexUploader http://paulkaplan.me/HexUploader/
- windows: XLoader http://russemotto.com/xloader/

run the app 
- select atmega328 
- select serial port (on mac similar to this: /dev/tty.usbserial-AD01SV3E)
- select desired .hex file
- hit upload button
##################

##################
using command line
-if you want to use command line you should know how to do that .)


