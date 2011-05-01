#include <opencv/highgui.h>

// Redundant work to wrap the buttons
// TODO: Abstract this using macros
void calibrateCallbackWrapper(int state, void*) {
	if(state == -1) { // for push buttons
		
	}
}

void testCallbackWrapper(int state, void*) {
	if(state == -1) { // for push buttons
		
	}		
}

void savePointsCallbackWrapper(int state, void*) {
	if(state == -1) { // for push buttons
		
	}
}

void loadPointsCallbackWrapper(int state, void*) {
	if(state == -1) { // for push buttons
		
	}
}

void clearPointsCallbackWrapper(int state, void*) {
	if(state == -1) { // for push buttons
		
	}
}

#define MAIN_WINDOW_NAME "OpenGazer"

int main(int argc, char **argv) {
	cvNamedWindow(MAIN_WINDOW_NAME, CV_GUI_EXPANDED);
	cvResizeWindow(MAIN_WINDOW_NAME, 640, 480);
	//Create the buttons
	cvCreateButton("Calibrate", calibrateCallbackWrapper);
	cvCreateButton("Test", testCallbackWrapper);
	cvCreateButton("Save Points", savePointsCallbackWrapper);
	cvCreateButton("Load Points", loadPointsCallbackWrapper);
	cvCreateButton("Clear Points", clearPointsCallbackWrapper);
	
  CvCapture* capture = cvCaptureFromCAM(-1);
  IplImage* frame;
  
while(1) {
      frame = cvQueryFrame(capture);
      if(!frame) break;
      cvShowImage(MAIN_WINDOW_NAME, frame);
      char c = cvWaitKey(33);
      if(c == 27) break;
  }
  cvReleaseCapture(&capture);
  cvDestroyWindow(MAIN_WINDOW_NAME);
	
	return 0;
}