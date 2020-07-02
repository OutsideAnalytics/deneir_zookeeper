
# -------- Outside Analytics Additions -------
buildchk:
	@if [[ ! -n $$VERSION ]] || [[ ! -n $$RELEASE ]]; \
	then \
	  echo "Usage: make rpm \"VERSION=x.y.z\" \"RELEASE=n\""; \
	  exit 1; \
	fi

rpm: buildchk
	@mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
	@if [[ -n `git tag --list release-${VERSION}` ]]; \
	then \
	  echo "Extracting git archive for tag: release-${VERSION}"; \
	  git archive --format tar.gz \
	              --output=rpmbuild/SOURCES/apache-zookeeper-${VERSION}.tar.gz \
	              --prefix=apache-zookeeper-${VERSION}/ \
	              release-${VERSION}; \
	else \
	  echo "Extracting git archive for HEAD (tag not found for: ${VERSION})"; \
	  git archive --format tar.gz \
	              --output=rpmbuild/SOURCES/apache-zookeeper-${VERSION}.tar.gz \
	              --prefix=apache-zookeeper-${VERSION}/ \
	              HEAD; \
	fi
	sed -e 's,xVERSIONx,${VERSION},' \
	    -e 's,xRELEASEx,${RELEASE},' \
	    zookeeper.spec >| rpmbuild/SPECS/zookeeper.spec
	cd rpmbuild/SPECS; \
	  rpmbuild --define "_topdir $$PWD/.." -ba zookeeper.spec
	@echo "Makefile.rpm done. Result in: $$PWD/rpmbuild/RPMS/x86_64"

