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

# SRC_DIR := .

LISP_FLAGS := --noinform --non-interactive
LISP_BUILD := "(progn (require :bulk-rename) (asdf:make :bulk-rename))"
LISP_TEST := "(progn (require :bulk-rename-test) (asdf:test-system 'bulk-rename))"

bulk-rename: *.lisp *.asd
	$(LISP) $(LISP_FLAGS) --eval $(LISP_BUILD)

test:
	$(LISP) $(LISP_FLAGS) --eval $(LISP_TEST)

clean:
	$(RM) bulk-rename
