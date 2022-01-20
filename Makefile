
GITHUB_API_TOKEN := $(shell cat ~/.gh_token)
OWNER := IBM
REPO := ibmi-bob
VERSION := $(shell curl --silent "https://api.github.com/repos/$(OWNER)/$(REPO)/releases/latest" | jq -r .tag_name | sed 's/^.//')

ifndef VERSION
$(error VERSION is not set)
endif

ifndef GITHUB_API_TOKEN
$(error GITHUB_API_TOKEN is not set)
endif

all: rpm

rpm:
	@echo "Packaging bob as an RPM ..."
	mkdir -p rpm/SOURCES rpm/BUILD rpm/BUILDROOT rpm/RPMS rpm/SPECS
	curl -o rpm/SPECS/bob.spec https://raw.githubusercontent.com/IBM/ibmi-bob/master/bob.spec 
	rpmbuild -ba --define "_topdir `pwd`/rpm" --define "bobVer $(VERSION)" rpm/SPECS/bob.spec
	find rpm/RPMS/ -name "*.rpm" -exec mv {} ./ \;
	rm -rf rpm

upload:
	bash upload-github-release-asset.sh github_api_token=$(GITHUB_API_TOKEN) owner=$(OWNER) repo=$(REPO) tag=v$(VERSION) filename=$(wildcard bob-$(VERSION)*.rpm)

.PHONY: clean
clean:
	rm -rf rpm *.rpm