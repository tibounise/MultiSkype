all: build/MultiSkype.app

clean:
	rm -rf build/

prepare-build:
	mkdir -p build/

build/MultiSkype: prepare-build src/MultiSkype.m
	gcc -o build/MultiSkype src/MultiSkype.m -framework Cocoa

build/MultiSkype.app: build/MultiSkype assets/MultiSkype.icns
	mkdir -p build/MultiSkype.app/Contents/{MacOS,Resources}
	cp -r assets/Info.plist build/MultiSkype.app/Contents/
	cp -r assets/MultiSkype.icns build/MultiSkype.app/Contents/Resources/
	cp -r build/MultiSkype build/MultiSkype.app/Contents/MacOS/MultiSkype
