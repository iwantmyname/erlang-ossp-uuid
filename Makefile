PROJECT = erlang-ossp-uuid
BUILD_DEPS = uuid
dep_uuid = tarball deps/uuid-1.6.2.tar.gz 1.6.2

define dep_fetch_tarball
		cd deps \
		&& tar xzvfpo uuid-1.6.2.tar.gz \
		&& mv uuid-1.6.2 uuid \
		&& cd uuid \
		&& CFLAGS= LDFLAGS= ./configure -disable-debug --without-perl --without-php --without-pgsql \
		&& rm -f configure.ac configure
endef

C_SRC_TYPE = bogus

CC = gcc
CFLAGS = -Ic_src -Ideps/uuid -g -Wall -fPIC -O3 -std=c99 -arch x86_64
LDFLAGS = deps/uuid/.libs/libuuid.a -bundle -arch x86_64 -flat_namespace -undefined suppress

include erlang.mk
