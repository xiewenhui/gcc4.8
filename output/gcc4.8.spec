Summary: gcc 4.8
Name: gcc
Version: 4.8
Release: 2
License: GPL
Source: gcc-4.8.tgz
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Group: System Environment/Daemons

%description
gcc 4.8 env

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && %{__rm} -rf %{buildroot}

%{__install} -d %{buildroot}/export/servers/gcc-4.8
cp -rf $RPM_BUILD_DIR/%{name}-%{version}/* %{buildroot}/export/servers/gcc-4.8/

%clean
[ "%{buildroot}" != "/"  ] && %{__rm} -rf %{buildroot}

%post

%preun

%postun

%files
    %defattr(-,root,root)
	%dir /export/servers/gcc-4.8
	%attr(0755,root,root) /export/servers/gcc-4.8/*
