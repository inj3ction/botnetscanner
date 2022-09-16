#!/bin/bash
yes|yum update -y
yes|yum install epel-release -y
yes|yum install cpan wget curl glibc.i686 -y
yes|cpan force install Parallel::ForkManager
yes|cpan force install IO::Socket
yes|cpan force install IO::Select
yes|yum install gcc php-devel php-pear libssh2 libssh2-devel libpcap -y
yes|pecl install -f ssh2
touch /etc/php.d/ssh2.ini
echo extension=ssh2.so > /etc/php.d/ssh2.ini
yes|cpan force install Net::SSH2
yes|yum update -y
yes|yum install gcc cmake gmp gmp-devel libpcap-devel gengetopt byacc flex -y
yes|yum install json-c-doc.noarch json-c.i686 json-c.x86_64 json-c-devel.i686 json-c-devel.x86_64 -y
yes|yum install epel-release -y
yes|yum install gengetopt -y
rm -rf v2.1.0.tar.gz
rm -rf zmap-2.1.0
wget https://github.com/zmap/zmap/archive/v2.1.0.tar.gz
tar -xvf v2.1.0.tar.gz
cd zmap-2.1.0
flex -o "src/lexer.c" --header-file="src/lexer.h" "src/lexer.l"
byacc -d -o "src/parser.c" "src/parser.y"
mkdir /etc/zmap
cp conf/* /etc/zmap
cmake -DENABLE_HARDENING=ON
make
make install
yes|yum install perl-Net-SSH2 -y
yes|yum install perl-Parallel-ForkManager -y