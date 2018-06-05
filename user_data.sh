#!/bin/bash
yum update -y
amazon-linux-extras install R3.4
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -P /tmp
yum install -y /tmp/epel-release-latest-7.noarch.rpm
yum groupinstall -y "Development Tools"
yum install -y libxml2 libxml2-devel
yum install -y openssl-devel
yum install -y libcurl-devel 
yum install -y libpng
yum install -y libtiff
yum install -y udunits2-devel
yum install -y postgresql-devel
yum install -y liblwgeom
yum install -y netcdf-devel
yum install -y hdf5-devel

# download and install proj4
cd /tmp
wget http://download.osgeo.org/proj/proj-4.9.3.tar.gz
wget http://download.osgeo.org/proj/proj-datumgrid-1.7.zip
tar -zvxf proj-4.9.3.tar.gz
cd proj-4.9.3/nad
unzip ../../proj-datumgrid-1.7.zip
cd ..
./configure
make
make install

# download and install geos
cd /tmp
wget http://download.osgeo.org/geos/geos-3.6.2.tar.bz2
tar -xjf geos-3.6.2.tar.bz2
cd geos-3.6.2

#Compile from source
./configure 
make
make install

# download and install GDAL
cd /tmp
wget http://download.osgeo.org/gdal/2.3.0/gdal-2.3.0.tar.gz

#Untar
tar xzf gdal-2.3.0.tar.gz
cd gdal-2.3.0

#Compile from source
./configure 
make
make install

echo /usr/local/lib >> /etc/ld.so.conf.d/libgdal-x86_64.conf
ldconfig

# install R packages as ec2-user
su - ec2-user -c "mkdir -p R/x86_64-pc-linux-gnu-library/3.3"
su - ec2-user -c "R install.packages('udunits2', \
configure.args='--with-udunits2-include=/usr/include/udunits2/', \
repos = 'https://ftp.osuosl.org/pub/cran/'')"
su - ec2-user -c "R install.packages('tidyverse', \
repos = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('devtools', \
repos = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('raster', \
repos = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('crawl', \
repos = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('future', \
repos = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('foreach', \
repos = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('doFuture', \
repose = 'https://ftp.osuosl.org/pub/cran/')"
su - ec2-user -c "R install.packages('furrr', \
repos = 'https://ftp.osuosl.org/pub/cran/')"

