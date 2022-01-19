rpm:
	@echo "Packaging bob as an RPM ..."
	mkdir -p rpm/SOURCES rpm/BUILD rpm/BUILDROOT rpm/RPMS rpm/SPECS
	wget -O rpm/SPECS/bob.spec https://raw.githubusercontent.com/IBM/ibmi-bob/master/bob.spec 
	rpmbuild -ba --define "bobVer $(VERSION)" rpm/SPECS/bob.spec
	find rpm/RPMS/ -name "*.rpm" -exec mv {} ./ \;
	rm -rf rpm
