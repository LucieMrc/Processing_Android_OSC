# Using Processing Android to communicate via OSC

**The goal is to use OSC communication to send data from an android phone to a Processing sketch.**

All of the code and the ideas are from the french creative coding master [b2renger](https://github.com/b2renger), from his repo [processing_osc_controller](https://github.com/b2renger/processing_osc_controller). My only contribution is the explaination of the code and the setup.

## Getting started on Mac

### Installing Android Mode

In order to create an android application with Processing, you need to download the Android Mode for Processing (in Processing 3.5.4, as it is not yet compatible with the last version of Processing 4.0).

![Screenshot of the top right corner of the Processing window](./images/screen1.png)

To do so, click on the Java Mode in the top right corner of the Processing window, and select `Add Mode...`.

![Screenshot of the Contribution Manager window](./images/screen2.png)

In the Contribution Manager Window, select `Android Mode` and install it.

### Setting up your phone

You need to activate Developer options on your phone by going into the parameters, then the About Phone section, and tap "Build number" 7 times.

![Screenshot of the phone screen](./images/screen3.png)

Then, connect your phone via USB to your computer. Finally, you can go in Developer options in the parameters and enable USB debugging.

### Back to Processing

On the menu bar, click on Android and make sure `App` is selected, and your phone is selected in the `Devices` tab.

![Screenshot of the Android tab](./images/screen4.png)

You will also you need to download the **oscP5** library : in the menu bar, click on *Sketch* > *Import Library...* > *Add Library* > Search for oscP5 and click Install.

![Screenshot of the library manager window](./images/screen5.png)


## OSC Controller Template

### Introduction

In the `osc_controller_template_android` folder, you can find the main processing sketch, and several tabs of the sketch.

![Screenshot of the Processing tabs](./images/screen6.png)

You don't need to change anything in these tabs : 
* `auto_discovery` allows the android app to find the processing receiver on the computer,
* `create_sensorTab` creates the sensor page on the app, 
* `create_settings` creates the settings page on the app, 
* `gui_classes` creates each graphic components, 
* `osc_messaging` sends the osc messages, 
* `pd_parser` scans PureData patches to find and create components.

### Pages

You can modify the code of the main sketch starting with the line 13 : the array `pages` allows you to store the pages that will appear on your android app. 

![Screenshot of the lines 12-22](./images/screen7.png)

The `Settings` page will allow you to connect your phone to your computer via OSC and chose the OSC client you will send data to.

The `Sensors` page will allow you to chose which datas from your phone sensors (mic, light, accelerometer and orientation) to send.

The `Test` page is created after the `Test.pd` PureData patch in the data folder : by opening the patch in PureData and changing its components, you change the page in your application.

![Screenshot of the Test page on the phone and the PureData patch](./images/screen8.png)
*Comparison of the Test page on the app and on the PureData patch.*

### Getting started with PureData interface

To edit the patch, switch to edit mode with ctrl+E. 

You can add button (as bang), toggle, sliders, radio buttons, touch surface and color selector surface (as canvas), by going to the menu bar > Add.

![Screenshot of the PureData add menu](./images/screen9.png)

With right-click > Properties, you can change the label and size of the component. 

![Screenshot of the PureData patch](./images/screen10.png)

For a **toggle**, you can modify the value if switched on (1 by default).

For a **slider**, you can modify its starting and ending value (0 to 127 by default). 

For a **radio button**, you can modify the amount of boxes.

You can label them as you want, but in order to create a touch surface canvas or a color selector surface, you need to add the mention "touch" or "color" in `Receive symbol`.

### Adding pages

You can therefore create as many pages based on PureData patch, by adding their name to the `pages` array, and adding the patch in the data folder.

In the sketch, the pages are created from the patches by the lines 52 to 55 :

![Screenshot of the lines 51-56](./images/screen11.png)

### Removing the Sensors page

If you don't need the Sensors page, you can take it off the `pages` array and change the line 52 from `int i = 2` to `int i = 1`, and comment the function `create_sensorTab();` from line 59.

![Screenshot of the lines 56-60](./images/screen12.png)

### Customisation 

You can change differents visuals settings in the lines 15 to 22. 

![Screenshot of the lines 51-56](./images/screen13.png)

## OSC Receiver

### OSC connection

First, you can open the sketch `simple_receiver`. When you run the sketch and the android app at the same time, both devices connected on the same wifi, you can press Scan on the Settings page, and the OSC client should appear. 

![Screenshot of the settings page](./images/screen14.png)

You can then press Connect, and your devices should be able to communicate via OSC.

If you go on the Test page, you can now interact in real time with the processing sketch.

![Screenshot of the settings page](./images/screen15.png)

Your android app is communicating via OSC with your processing sketch.

### Understanding the sketch

The lines 16 to 24 are the declarations of the variables we want to get from the app :

![Screenshot of the lines 16-24](./images/screen16.png)

The function `draw`, lines 37 to 59, we use the variables we declared to show the data we receive in real time.

![Screenshot of the lines 37-59](./images/screen17.png)

The function `oscEvent`, lines 66 to 144, retrieves the data sent via OSC and analyze them to get the values from the component.

For example, for the button, it checks if the label in the osc message is the one we set for the button, then it updates `backColor` with a random color.

![Screenshot of the lines 87-92](./images/screen18.png)

For sliders, it checks for the label, and update the value `hsl1` with the value of the slider, with `get(0)`.

![Screenshot of the lines 102-106](./images/screen19.png)

Another example with the touch surface : it checks for the label, and then update `w` with the first value (the x position on the surface) with `get(0)`, and update `h` with the second value (the y position on the surface) with `get(1)`.
![Screenshot of the lines 126-131](./images/screen20.png)

## Simple receiver and simple controller

If you open both the `simple_sketch_controller` (as an android app), and the `simple_sketch_receiver` (as a sketch on your computer), you can use the touch surface to move a circle on the sketch, and control its color with the color surface.

#
# Using Open Stage Control to communicate via OSC

The goal is to use OSC communication to send data to a Processing sketch via an Open Stage Control interface in a web browser.

## Getting started

Download [Open Stage Control](http://openstagecontrol.ammd.net/download/) and open the application.

The first window you encounter is the launcher window.
If you click on the `play` button, you can see the local adress where you can find your interface on the web server.

![Screenshot of the launcher](./images/screen21.png)

At the same time, the client window opens....
