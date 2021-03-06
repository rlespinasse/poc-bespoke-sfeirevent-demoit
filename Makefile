.DEFAULT_GOAL = build

.PHONY: need-gulp
need-gulp:
	type gulp || npm install -g gulp-cli

.PHONY: build
build: need-gulp configure
	gulp

.PHONY: clean
clean:
	rm -rf dist || true

# Slides server
PORT ?= 8088
SLIDES_SERVER := http://localhost:$(PORT)

.PHONY: serve-slides
serve-slides: need-gulp configure
	PORT=$(PORT) gulp serve

.PHONY: show-slides
show-slides:
	open $(SLIDES_SERVER)

# Demo server
.PHONY: serve-demo
serve-demo:
	type demoit || go get -u github.com/dgageot/demoit
	demoit -dev demo

# Configuration
.PHONY: configure
configure: node_modules .bundle/gems

node_modules:
	type yarn || npm install -g yarn
	yarn

.bundle/gems:
	type bundle || gem install bundler
	bundle --path=.bundle/gems

.PHONY: reset-configuration
reset-configuration: clean
	rm -rf node_modules || true
	rm -rf .bundle || true
