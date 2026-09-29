bin/ydat: src/ydat.fish
	mkdir -p bin
	cp $^ $@
	chmod +x $@
