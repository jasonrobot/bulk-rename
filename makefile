# CC=gcc
# RM=rm -f

# SRC_DIR := src
# OBJ_DIR := obj
# INC_FILES := $(wildcard $(SRC_DIR)/*.h)
# SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
# OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))
# $_LDFLAGS := -g -Wall
# $_CFLAGS := -g -Wall

LISP=sbcl
RM=rm -f

LISP_FLAGS := --noinform --non-interactive

bulkrename:
	$(LISP) $(LISP_FLAGS) --eval  "(progn (require :bulk-rename) (asdf:make :bulk-rename))"

test:
	$(LISP) $(LISP_FLAGS) --eval "(progn (require :bulk-rename-test) (asdf:test-system 'bulk-rename))"

all:
