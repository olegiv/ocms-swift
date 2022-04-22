CUR_DIR = $(CURDIR)

clean:
	rm -rfv .build
	
build:
	swift build

run:
	swift run

install:
	swift package update
	swift build -c release -Xswiftc -cross-module-optimization
	mkdir -p .bin 
	install .build/release/Run ./.bin/

uninstall:
	rm -rfv .bin

load-test:
	wrk -t10 -c400 -d30s http://localhost:8080/
	
