CC	= arm-linux-gnueabihf-gcc
CFLAGS	= -O1 -Wall -g3 -march=armv7-a -mfpu=vfp -mfloat-abi=hard
LDFLAGS = -lrt -static

objects	= pi_cal.o pi_vfp_baseline.o

default: pi_cal

pi_cal: $(objects)
	$(CC) $(LDFLAGS) -o $@ $^

pi_vfp_baseline.o: pi_vfp_baseline.s
pi_cal.o: pi_cal.c

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.s
	$(CC) -c $(CFLAGS) -o $@ $<

clean:
	rm -f $(objects) pi_cal


