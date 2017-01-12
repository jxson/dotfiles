
TARGET = ~/
cur-dir := $(shell pwd)/

install: ../.gitignore ../.gitconfig ../.bashrc ../.bash_profile ../.inputrc ../.hyper.js
	source ~/.bash_profile
	bash

../.gitignore:
	ln -s $(join $(cur-dir), .gitignore) $(join $(TARGET), .gitignore)

../.gitconfig:
	ln -s $(join $(cur-dir), .gitconfig) $(join $(TARGET), .gitconfig)

../.bashrc:
	ln -s $(join $(cur-dir), .bashrc) $(join $(TARGET), .bashrc)

../.bash_profile:
	ln -s $(join $(cur-dir), .bash_profile) $(join $(TARGET), .bash_profile)

../.inputrc:
	ln -s $(join $(cur-dir), .inputrc) $(join $(TARGET), .inputrc)

../.hyper.js:
	ln -s $(join $(cur-dir), .hyper.js) $(join $(TARGET), .hyper.js)

clean:
	rm $(join $(TARGET), .hyper.js)
	rm $(join $(TARGET), .gitignore)
	rm $(join $(TARGET), .gitconfig)
	rm $(join $(TARGET), .bashrc)
	rm $(join $(TARGET), .bash_profile)
	rm $(join $(TARGET), .inputrc)

.PHONY: install clean
