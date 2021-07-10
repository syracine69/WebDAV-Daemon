CFLAGS=-O3 -s
STATIC_FLAGS=-Werror -Wall -Wno-pointer-sign -Wno-unused-result -std=gnu99 -pthread -lpq
#-Wno-unused-result
all: build/rap build/webdavd
	ls -lh $^

build/webdavd: build/webdavd.o build/shared.o build/configuration.o build/xml.o
	gcc ${CFLAGS} ${STATIC_FLAGS} -o $@ $(filter %.o,$^) -lmicrohttpd -lxml2 -lgnutls -luuid

build/rap: build/rap.o build/shared.o build/xml.o
	gcc ${CFLAGS} ${STATIC_FLAGS} -o $@ $(filter %.o,$^) -lpam -lxml2 
build/%.o: %.c makefile | build
	gcc ${CFLAGS} ${STATIC_FLAGS} -MMD -o $@ $(filter %.c,$^) -I/usr/include/libxml2 -I/usr/include/postgresql -c

build:
	mkdir $@
	
clean:
	rm -rf build
	
package: all
	cd build; package-project ../manifest

-include build/*.d
