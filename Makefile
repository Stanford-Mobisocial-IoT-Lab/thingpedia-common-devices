NULL =

zipfiles = \
	org.thingpedia.bluetooth.generic.zip \
	com.twitter.zip \
	com.bodytrace.scale.zip \
	com.parklonamerica.heatpad.zip \
	us.sportradar.zip \
	yr.no.weather.zip \
	org.thingpedia.test.zip \
	com.facebook.zip \
	com.google.zip \
	com.jawbone.up.zip \
	com.twilio.zip \
	com.foaas.zip \
	com.nest.zip \
	com.tesla.zip

all: $(zipfiles)

%.zip: build/%
	cd $< ; \
	npm install --only=prod --no-optional ; \
	npm dedupe ; \
	zip -r $(abspath $@) *

node_modules:
	test -d ./node_modules || mkdir ./node_modules
	npm install babel-cli babel-preset-es2015

empty =
space = $(empty) $(empty)
comma = ,

BABEL_IGNORE = \
	jsapp/node_modules/*/test/* \
	$(NULL)

build/%: % node_modules
	./node_modules/.bin/babel --preset es2015 --ignore $(subst $(space),$(comma),$(BABEL_IGNORE)) -D -d $@ $<

clean:
	rm -f *.zip
