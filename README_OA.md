# deneir-zookeper
ZooKeeper C interface and command line build.

# RPM Build Instructions
## RedHat 8
```
git clone https://github.com/OutsideAnalytics/deneir_zookeeper.git
cd deneir_zookeeper
checkout oa-build
make rpm "VERSION=3.6.1" "RELEASE=0"
cd rpmbuild/RPMS/x86_64
dnf install zookeeper-c-3.6.1-0.el8.x86_64.rpm
```
Notes:
* If a git tag exists that matches the VERSION number, then that tag is built, otherwise
the HEAD of the current branch is built.
* The RPM produced is in *deneir_zookeepr/rpmbuild/RPMS/x86_64/*

# Dependency lists
## RedHat 8
Base Image: _registry.access.redhat.com/ubi8/ubi_

There are no other dependencies.

