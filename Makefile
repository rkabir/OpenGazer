# required libraries: vxl, opencv, boost, gtkmm

VXLDIR = /opt/local
VERSION = opengazer-0.1.2
CPPFLAGS = -Wall -g -O3
LINKER = -L/opt/local/lib/vxl -L/usr/local/lib -L/opt/local/lib -lm -ldl -lvnl -lmvl -lvnl_algo -lvgl -lgthread-2.0 

# change the following line if your vxl library is installed elsewhere
INCLUDES = $(foreach prefix,/opt/local/include $(VXLDIR)/include $(VXLDIR)/include/vxl, \
	$(foreach suffix,/core /vcl /contrib/oxl,-I$(prefix)$(suffix)))

# -I/usr/include/ffmpeg
# -lcv0.9.7 -lhighgui0.9.7
# -lvgui

sourcesHighGui = opengazerHighGui.cpp Calibrator.cpp HeadTracker.cpp LeastSquares.cpp EyeExtractor.cpp GazeTracker.cpp MainGazeTracker.cpp OutputMethods.cpp PointTracker.cpp FaceDetector.cpp TrackingSystem.cpp WindowStore.cpp Containers.cpp GraphicalPointer.cpp Point.cpp utils.cpp BlinkDetector.cpp FeatureDetector.cpp 

objectsHighGui = $(patsubst %.cpp,%.o,$(sourcesHighGui))

%.o.depends: %.cpp
	g++ -MM $< > $@

%.o: %.cpp 
	g++ -c $(CPPFLAGS) -o $@ `pkg-config opencv --cflags` $(INCLUDES) $< 

opengazerHighGui: 	$(objectsHighGui)
		g++ $(CPPFLAGS) -o $@ `pkg-config cairomm-1.0 opencv gtkmm-2.4 --libs`  $(LINKER) $^

include $(patsubst %.cpp,%.o.depends,$(sources))

clean:
	rm -rf opengazerHighGui *.o *.o.depends

TAGS: always
	etags *.cpp *.h

ship: always
	mkdir $(VERSION) || rm -fr $(VERSION)/*
	cp LICENSE README Makefile calpoints.txt haarcascade_frontalface_alt.xml $$(for file in $$(cat $(addsuffix .depends,$(objects))) ; do test -f $$file && echo $$file ; done | sort -u) $(VERSION)/
	tar czf $(VERSION).tar.gz $(VERSION)
	cp $(VERSION).tar.gz README /home/ftp/pub/www/opengazer/

.PHONY: always ship