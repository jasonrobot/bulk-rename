LISP=sbcl
RM=rm -f

LISP_FLAGS := --noinform --non-interactive
LISP_BUILD := "(progn (require :bulk-rename) (asdf:make :bulk-rename))"
LISP_TEST := "(progn (require :bulk-rename-test) (asdf:test-system 'bulk-rename))"

bulk-rename: *.lisp *.asd
	$(LISP) $(LISP_FLAGS) --eval $(LISP_BUILD)

test:
	$(LISP) $(LISP_FLAGS) --eval $(LISP_TEST)

clean:
	$(RM) bulk-rename
