minitest: minitest.c
	afl-gcc $< -o $@

run: minitest
	./minitest inputs/alice.txt

fuzz: minitest
	mkdir -p findings
	afl-fuzz -i inputs -o findings -- ./minitest @@


