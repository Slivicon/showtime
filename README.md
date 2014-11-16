showtime
========

Showtime is a mod for Farming Simulator 15 which displays the real world time within the game.

Simply copy the zip to your mods folder which is located in the same place where your saved games are stored.

By default, the time will show below the game time.

When first loaded, showtime will write a file called "showtime.xml" to the mods folder, which allows for configuration.

The following properties are configurable:

***fontSize***  
The default size is 0.018, but any size between 0.000 and 1.000 is accepted.

***posDynamic***  
If this is set to "true" (default), then showtime will dynamically calculate a position just below the game time. If it is set to false, then the "posX" and "posY" values are used.

***posX***  
This is the horizontal position. Any value between 0.000 (left) and 1.000 (right) is accepted. The default is 0, but is ignored due to the default being a dynamic calculation. 

***posY***  
This is the vertical position. Any value between 0.000 (bottom) and 1.000 (top) is accepted. The default is 0, but is ignored due to the default being a dynamic calculation.

***timeFormat24***  
If this is set to "true" (default), then the time will be displayed in 24 hour format. If it is "false", then the time will be displayed in 12 hour format.

***showSeconds***  
If this is set to "true", then the time will also display the seconds. If it is "false" (default), then the seconds will not be displayed.

Notes
========
* If any of the properties are missing, the entire xml configuration will be ignored.
* Invalid properties are ignored.
* To revert to the default settings, simply rename or delete the "showtime.xml" file from the mods folder (a new one will be generated at next load).
* An example of showing the time below the mini-map in white would be to update "showtime.xml" with ***white="true"***, ***posDynamic="false"***, ***posX="0.045"*** and ***posY="0.007"***
