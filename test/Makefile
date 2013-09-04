
SRC=main.d testDeviceFactory.d testApplication.d ../build/dw.a

all:
	make -C..
	dmd $(SRC) -I../src -L-lGL -L-lglfw -g -J../src -debug -ofa.out
