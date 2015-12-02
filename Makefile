PROJECT = erlang-ossp-uuid
BUILD_DEPS = ossp-uuid
dep_ossp-uuid = git_and_configure https://github.com/sean-/ossp-uuid master

define dep_fetch_git_and_configure
	git clone -q -n -- $(call dep_repo,$1) $(DEPS_DIR)/$(call dep_name,$1); \
		cd $(DEPS_DIR)/$(call dep_name,$1) && git checkout -q $(call dep_commit,$1); \
		./configure -disable-debug --without-perl --without-php --without-pgsql; \
		rm -f configure.ac configure
endef

C_SRC_TYPE = bogus

CC = gcc
CFLAGS = -Ic_src -I$(DEPS_DIR)/ossp-uuid -g -Wall -fPIC -O3 -std=c99 -arch x86_64
LDFLAGS = $(DEPS_DIR)/ossp-uuid/.libs/libuuid.a -bundle -arch x86_64 -flat_namespace -undefined suppress

include erlang.mk
