VERSION := $(shell bin/hiptask version)

all: build

build:
	gem build hiptask.gemspec

install: uninstall
	@if [ ! -e "${VERSION}.gem" ]; then echo "There is no gem built ready to install. Run make first"; exit 1; fi
	gem install ${VERSION}.gem

uninstall:
	gem uninstall -a -i -x hiptask

clean:
	rm -f *.gem
