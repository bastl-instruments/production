# Uploading a hex file into Bastl Instruments product

There are three ways of uploading the hex file to the device
 - via dedicated upload.command file
 - via dedicated utility app
 - via command line (not described here; look into upload.command)


## Dependencies
  * You need to have drivers for your FTDI Adapter installed. Some of the ship with arduino IDE. So installing it should be a first try.
  * For updating the hex files you need git


## Upload.command

  * after downloading first run setup.command file - this sets the serial port . 
  * select one that looks similar to this: /dev/tty.usbserial-AD01SV3E
  * write its number and hit enter
  * close the setup.command window

  * run upload.command
  * write number of desired code to upload and hit enter
  * you should get confirmation of correct upload in the window
  * hit enter to repeat

## Automatic Update of the .hex files
  * there is update.command file to make automatic updates of the whole hex file folder from github
  * this should get you the latest versions of the hex files
  * to be able to do this download and install git (depending on your dis -> register and than go to add repository -> clone and find the bastl/production repository
  * than if you run the update.command in such folder it should get you the latest updates


## Flashing Attiny85
  * for uploading the firmware to attiny 85 on MIDI Bastl go to attiny folder and run upload.command
  * you need to have hardware for uploading to attiny prepared as described here http://highlowtech.org/?p=1695



## Using Dedicated app
get the app for your system
- mac & linux: HexUploader http://paulkaplan.me/HexUploader/
- windows: XLoader http://russemotto.com/xloader/

run the app 
- select atmega328 
- select serial port (on mac similar to this: /dev/tty.usbserial-AD01SV3E)
- select desired .hex file
- hit upload button
##################




