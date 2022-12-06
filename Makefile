ALLIBS := $(patsubst %_module.cc, %.so, $(wildcard *_module.cc))

all: $(ALLIBS)

%.so: %_kernel.o %_module.o 
	g++ -std=c++14 -shared -o $@ $^ $(TF_OPS_CFLAGS) -fPIC $(TF_OPS_LFLAGS)
	ln -sf compiled/$@  ../$@ 

%_module.o: %_module.cc	
	g++ -std=c++14 -c -o $@ $< $(TF_OPS_CFLAGS) -fPIC

%_kernel.o: %_kernel.cc
	g++ -std=c++14 -c -o $@ $< $(TF_OPS_CFLAGS) -fPIC

clean:
	rm -f $(ALLIBS)

.PRECIOUS: %.o
