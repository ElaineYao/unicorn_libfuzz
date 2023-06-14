CFLAGS += -g -L ../../ -I ../../include

UNAME_S := $(shell uname -s)
LDFLAGS += -pthread
ifeq ($(UNAME_S), Linux)
LDFLAGS += -lrt
endif

LDFLAGS += ../../build/libunicorn.a


ALL_TESTS_SOURCES = $(wildcard fuzz*.c)
ALL_TESTS = $(ALL_TESTS_SOURCES:%.c=%)

.PHONY: all
all: ${ALL_TESTS}

.PHONY: clean
clean:
	rm -rf ${ALL_TESTS}

fuzz%: fuzz%.c
	clang $(CFLAGS) -fsanitize=address,fuzzer $^ $(LDFLAGS) -o $@ -lm
