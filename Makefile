CC = gcc
CFLAGS = -Wall -fPIC
LDFLAGS = -shared
TARGET_LIB = libconvert.so
TARGET_EXEC = text_formatter
SRCS = $(filter-out src/main.c, $(wildcard src/*.c))
OBJS = $(SRCS:.c=.o)
MAIN_OBJ = src/main.o

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
LIBDIR = $(PREFIX)/lib

all: $(TARGET_LIB) $(TARGET_EXEC)

$(TARGET_LIB): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

$(TARGET_EXEC): $(MAIN_OBJ) $(TARGET_LIB)
	$(CC) -o $@ $< -L. -lconvert

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

install: $(TARGET_LIB) $(TARGET_EXEC)
	install -d $(BINDIR) $(LIBDIR)
	install -m 755 $(TARGET_EXEC) $(BINDIR)
	install -m 755 $(TARGET_LIB) $(LIBDIR)
	ldconfig

uninstall:
	rm -f $(BINDIR)/$(TARGET_EXEC)
	rm -f $(LIBDIR)/$(TARGET_LIB)

clean:
	rm -f $(OBJS) $(TARGET_LIB) $(MAIN_OBJ) $(TARGET_EXEC)

.PHONY: all clean install uninstall