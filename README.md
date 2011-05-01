OpenGazer using MacPorts
========================

This has been tested on a MacBook Pro with built-in iSight camera running OS X
10.6

1. Download and install the latest version of [MacPorts] (http://www.macports.org/)
1. Install the following packages from MacPorts. Note that this might take a long time since all these packages have a lot of dependencies:
  - sudo port install vxl
  - sudo port install opencv +python26 +qt4 + tbb (_Python variant not strictly necessary but useful for quick experiments; Qt gives you very nice buttons; TBB gives speedup for some tasks on multicore machines_)
  - sudo port install boost

For reference, during my development phase, I was compiling with Apple's GCC (
gcc version 4.2.1 (Apple Inc. build 5664)). And these are the versions of the software
that I was using:

  - vxl (@1.14.0)
  - opencv (@2.2.0)
  - boost (@1.46.1)

Instructions
------------

1. If you are using MacPorts, the Makefile should work properly. If you are
   using a different system, please check to see that the locations to the 
   header files and libraries are correct.

2. Put the camera centrally under you monitor, so that the height of
   your face in the image is about half of the height of the image,
   and close to the centre of the image.  Make sure the background
   light level is reasonably constant across the image.

3. Start the opengazerHighGui program

   > ./opengazerHighGui

4. While keeping your head still, use the mouse to select points on
   your face that will be used to track your head.  The first two
   points much be eye corners.  Select at least two other salient
   points (recommended 7-8 in total).  Double-clicking on an existing
   point removes it.  The first two points (corresponding to eye
   corners) will be blue, the other will be green.  When a point
   becomes red, it means that it lost track.  When you are happy with
   your selection, click "Save points".

   You need at least four points in total, but I recommend 7-8.  Once
   they have been selected, the position of your head will be tracked
   and the rotation estimates displayed as white and blue lines from
   the center of the screen.  The blue line indicates the difference
   in head position between the first frame and the current position:
   make sure that it is as short as possible at all times!

5. Now you can exit the program, run it again, click "load points",
   and the points you selected in point 3 should appear.  You have
   probably noted a white and blue line in the center of the image;
   they indicate the current rotation of your head.  The shorter the
   blue line, the closer your head position is to the original.  While
   using the gaze tracker, try to orient your head so that the length
   of the blue line is as small as possible.

6. The next step is calibration.  Remember, in order for this gaze
   tracker to work, you must keep your head absolutely still.  Press
   "Calibrate".  You will now be asked to look at various points on
   the screen, indicated by a red circle.  Remember: do not move your
   head, only your eyes!  

7. During the calibration and afterwards, a small blue will indicate
   the estimated position of your gaze focus.

Developing OpenGazer
--------------------

1. The coordinates of the calibration points are stored in
   "calpoints.txt".  Feel free to change them.  For example, by having
   only two calibration points: one on the left of the screen, and the
   other on the right, you can use opengazer as a binary switch.

2. Opengazer shows the current estimate of the gaze point as a small
   purle circle on the screen.  

   It also outputs this information to the standard output.  Each line
   has the format

   Xcoordinate Ycoordinate -> IDoftheclosestcalibrationpoint

   Opengazer also opens a local UDP socket at port 20230 to which it
   sends the current estimates X and Y.  

   To add more output methods, or to change the existing one, take a
   look at files "OutputMethods.cpp" and "OutputMethods.h".

3. Other files used by opengazer

   calpoints.txt   Coordinates calibration points 
   		   (as fraction of the screen)

   points.txt      Coordinates of the tracking points on the user face, in
   		   pixels.  This file is saved when the user clicks
   		   "Save points"
   
   