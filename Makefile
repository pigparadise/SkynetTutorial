.PHONY: all clean build lua53 skynet

TOP=$(PWD)
BIN_DIR=./bin
BUILD_DIR=./build

INCLUDE_DIR=$(BUILD_DIR)/include
BUILD_STATIC_LIB=$(BUILD_DIR)/static_lib
BUILD_LUALIB_DIR=$(BUILD_DIR)/lualib
BUILD_CLUALIB_DIR=$(BUILD_DIR)/clualib
BUILD_CSERVICE_DIR=$(BUILD_DIR)/cservice

all: build
build:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BIN_DIR)
	mkdir -p $(INCLUDE_DIR)
	mkdir -p $(BUILD_STATIC_LIB)
	mkdir -p $(BUILD_LUALIB_DIR)
	mkdir -p $(BUILD_CLUALIB_DIR)
	mkdir -p $(BUILD_CSERVICE_DIR)


# lua begin
all: lua53
LUA_LIB = $(BUILD_STATIC_LIB)/liblua.a
LUA_INC = $(INCLUDE_DIR)

lua53:
	cd skynet/3rd/lua/ && $(MAKE) MYCFLAGS="-O2 -fPIC -g -I../../skynet-src" linux
	install -p -m 0755 skynet/3rd/lua/lua $(BIN_DIR)/lua
	install -p -m 0755 skynet/3rd/lua/luac $(BIN_DIR)/luac
	install -p -m 0644 skynet/3rd/lua/liblua.a $(BUILD_STATIC_LIB)
	install -p -m 0644 skynet/3rd/lua/lua.h $(INCLUDE_DIR)
	install -p -m 0644 skynet/3rd/lua/lauxlib.h $(INCLUDE_DIR)
	install -p -m 0644 skynet/3rd/lua/lualib.h $(INCLUDE_DIR)
	install -p -m 0644 skynet/3rd/lua/luaconf.h $(INCLUDE_DIR)

# lua end

# skynet begin
all: skynet
skynet:
	cd skynet && $(MAKE) PLAT=linux SKYNET_BUILD_PATH=../$(BIN_DIR) LUA_CLIB_PATH=../$(BUILD_CLUALIB_DIR) CSERVICE_PATH=../$(BUILD_CSERVICE_DIR)
	cp skynet/skynet-src/skynet_malloc.h $(INCLUDE_DIR)
	cp skynet/skynet-src/skynet.h $(INCLUDE_DIR)
	cp skynet/skynet-src/skynet_env.h $(INCLUDE_DIR)
	cp skynet/skynet-src/skynet_socket.h $(INCLUDE_DIR)


clean:
	rm -rf build
	cd skynet && $(MAKE) clean
	cd skynet/3rd/lua/ && $(MAKE) clean


all:
	@echo "all done"
