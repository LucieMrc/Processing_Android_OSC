/**
 * based on oscP5parsing example by andreas schlegel
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

String sketchName = "processing_test";
int inPort = 10000;
int outPort = 12000;

color c = 255; // being get from color1
float hsl1; // being get from hslider1
float vsl1; // being get from vslider1
float w; // being get from touch1
float h; // being get from touch1
boolean toggle = false; // being get from Toggle1
color backColor = color(0); // pressing button1 will get you a new random color
float hrd1; //being get from the hradio1
float vrd1; //being get from the vradio1

void setup() {
  size(400, 300);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port inPort
   port needs to match the one you are sending to !
  */
  oscP5 = new OscP5(this, inPort);
  println(oscP5.ip(), inPort);
  myRemoteLocation = new NetAddress("127.0.0.1", outPort);
}

void draw() {
  noStroke();
  fill(0, 150);
  rect(0, 0, width, height);
  
  fill(c);
  float x = map(w, 0, 127, 0, width);
  float y = map(h, 0, 127, 0, height);
  circle(x, y, 10);

}



/*
Parsing occurs here !
 */
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  //println("### received an osc message.");

  // this first one is for auto-identification - it shouldn't have to be edited
  if (theOscMessage.checkAddrPattern("/id")==true) { 
    println("id response " + inPort);
    OscMessage myMessage = new OscMessage("/ready");
    myMessage.add(sketchName); 
    myMessage.add("/" + oscP5.ip()); 
    myMessage.add(str(inPort)); 
    String []  ips = split( oscP5.ip(), '.'); // get the ip address pattern on this network
    String broad_IP = ips[0] +"."+ ips[1]+"." + str(255)+"." + str(255); // replace last by 255 for broadcast
    // send a broadcasted message
    //println(oscP5.ip(), inPort);
    NetAddress map = new NetAddress("255.255.255.255", outPort);
    oscP5.send(myMessage, map);
    return;
  }

  // below this lines are each controllers

  /*get values from the pad input*/
  if (theOscMessage.checkAddrPattern("/touch1")==true) { 
    w = theOscMessage.get(0).floatValue();
    h = theOscMessage.get(1).floatValue();
    return;
  }  

  /*get values from the color selector color*/
  if (theOscMessage.checkAddrPattern("/color1")==true) { 
    float red = theOscMessage.get(0).floatValue();
    float green = theOscMessage.get(1).floatValue();
    float blue = theOscMessage.get(2).floatValue();
    c = color(red, green, blue);
    return;
  }

  // the line below could be useful for debugging incomming messages
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern()+theOscMessage.get(0).floatValue());
}
