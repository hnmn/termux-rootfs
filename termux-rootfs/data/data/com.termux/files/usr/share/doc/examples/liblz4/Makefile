# ##########################################################################
# LZ4 examples - Makefile
# Copyright (C) Yann Collet 2011-2014
#
# GPL v2 License
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# You can contact the author at :
#  - LZ4 source repository : https://github.com/Cyan4973/lz4
#  - LZ4 forum froup : https://groups.google.com/forum/#!forum/lz4c
# ##########################################################################
# This makefile compile and test
# example programs, using (mostly) LZ4 streaming library,
# kindly provided by Takayuki Matsuoka
# ##########################################################################

CFLAGS   ?= -O2
CFLAGS   += -std=gnu99 -Wall -Wextra -Wundef -Wshadow -Wcast-align -Wstrict-prototypes
FLAGS    := $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)

TESTFILE= Makefile

# Define *.exe as extension for Windows systems
ifneq (,$(filter Windows%,$(OS)))
EXT =.exe
VOID = nul
else
EXT =
VOID = /dev/null
endif


default: all

all: printVersion doubleBuffer dictionaryRandomAccess ringBuffer ringBufferHC \
     lineCompress frameCompress simpleBuffer

printVersion: printVersion.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

doubleBuffer: blockStreaming_doubleBuffer.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

dictionaryRandomAccess: dictionaryRandomAccess.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

ringBuffer: blockStreaming_ringBuffer.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

ringBufferHC: HCStreaming_ringBuffer.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

lineCompress: blockStreaming_lineByLine.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

frameCompress: frameCompress.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

compressFunctions: compress_functions.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

simpleBuffer: simple_buffer.c
	$(CC)      $(FLAGS) $^ -o $@$(EXT) -llz4

test : all
	./printVersion$(EXT)
	./doubleBuffer$(EXT) $(TESTFILE)
	./dictionaryRandomAccess$(EXT) $(TESTFILE) $(TESTFILE) 1100 1400
	./ringBuffer$(EXT)   $(TESTFILE)
	./ringBufferHC$(EXT) $(TESTFILE)
	./lineCompress$(EXT) $(TESTFILE)
	./frameCompress$(EXT) $(TESTFILE)
	./simpleBuffer$(EXT)
	$(LZ4) -vt $(TESTFILE).lz4

clean:
	@rm -f core *.o *.dec *-0 *-9 *-8192 *.lz4s *.lz4 \
	 printVersion$(EXT) doubleBuffer$(EXT) dictionaryRandomAccess$(EXT) \
	 ringBuffer$(EXT) ringBufferHC$(EXT) lineCompress$(EXT) frameCompress$(EXT) \
	 compressFunctions$(EXT) simpleBuffer$(EXT)
	@echo Cleaning completed
