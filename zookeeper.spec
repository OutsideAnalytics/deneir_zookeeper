Name:           zookeeper
Version:        xVERSIONx
%global         prefix_path /usr/local/zookeeper
Release:        xRELEASEx%{?dist}
Summary:        Apache ZooKeeper, a centralized distributed configuration service.
License:        GPL
URL:            https://github.com/OutsideAnalytics/deneir_zookeeper.git
Source0:        apache-%{name}-%{version}.tar.gz
BuildRequires:  chrpath
#Requires:       


%description
ZooKeeper is an open source Apache project that provides a centralized service
for providing configuration information, naming, synchronization and group
services over large clusters in distributed systems. 

%package c
Summary:	ZooKeeper C commands, headers, and library.
Provides:	%{name}-c

%description c
ZooKeeper C commands, headers, and library.

%prep
%setup -q -n apache-%{name}-%{version}

%build
mvn -pl zookeeper-jute clean install
cd zookeeper-client/zookeeper-client-c
autoreconf -fi
./configure --prefix=%{prefix_path}
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
cd zookeeper-client/zookeeper-client-c
%make_install

libtool --finish $RPM_BUILD_ROOT%{prefix_path}/lib

for exe in cli_mt load_gen cli_st
do
  chrpath --delete $RPM_BUILD_ROOT%{prefix_path}/bin/$exe
done

%files c
%{prefix_path}/bin/*
%{prefix_path}/lib/*
%{prefix_path}/include/*

%doc

%changelog
