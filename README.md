# Bulk Rename

This is a clone of the bulk-rename functionality in xfce's file manager Thunar. In Thunar, if you select multiple files and hit "F2", you can apply renaming operations to multiple files at once.

_all this is WIP for a while_

### Why lisp

Part of this is a fun project to learn lisp with. I could have done this is just about any other language like Python, Ruby, Java, Rust, etc. but I've been using lisp a bit lately, and really enjoying it.

# Command Syntax:

Insertion:
bulk-rename FILES insert STRING at POSITION

Overwrite:
bulk-rename FILES overwrite STRING at POSITION

Numbering:
bulk-rename FILES numbering from START separator STRING

Removal:
bulk-rename FILES remove from START to END

Replace:
bulk-rename FILES replace STRING with STRING

Regexp:
bulk-rename FILES regex STRING replace STRING

Change Case:
bulk-rename FILES case (UPPER|UP|LOWER|DOWN|CAMEL|SNAKE|LISP|KEBAB)
