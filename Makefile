TF_CFLAGS := $(python3 -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))' 2> /dev/null)
TF_LFLAGS := $(python3 -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))' 2> /dev/null)

ALLIBS := $(patsubst %_module.cc, %.so, $(wildcard *_module.cc))

all: $(ALLIBS)

%.so: %_kernel.o %_module.o 
	g++ -std=c++14 -shared -o $@ $^ $(TF_CFLAGS) -fPIC $(TF_LFLAGS)
	ln -sf compiled/$@  ../$@ 

%_module.o: %_module.cc	
	g++ -std=c++14 -c -o $@ $< $(TF_CFLAGS) -fPIC

%_kernel.o: %_kernel.cc
	g++ -std=c++14 -c -o $@ $< $(TF_CFLAGS) -fPIC

clean:
	rm -f $(ALLIBS)

.PRECIOUS: %.o
