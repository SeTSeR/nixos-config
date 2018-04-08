c_temp = /tmp/_asm_build_$$.c
o_temp = /tmp/_asm_build_$$.o
YASMFLAGS = -felf32 -mx86 -g dwarf2 -DUNIX
CFLAGS = -m32 -g
LDFLAGS = -m32

%: %.o $(o_temp)
	$(CC) $(CFLAGS) $< $(o_temp) -o $@ $(LDFLAGS)
	rm -f $(c_temp) $(o_temp) $<

%.o: %.asm
	yasm $(YASMFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@ $(LDFLAGS)

$(c_temp):
	echo '#include <stdio.h>' >> $(c_temp)
	echo 'FILE *get_stdin(void) { return stdin; }' >> $(c_temp)
	echo 'FILE *get_stdout(void) { return stdout; }' >> $(c_temp)
