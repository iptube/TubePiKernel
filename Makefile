
obj-m := hello-1.o

all:
	@$(MAKE) -C $(KERNEL_HEADERS) M=$(PWD) modules

clean:
	@$(MAKE) -C $(KERNEL_HEADERS) M=$(PWD) clean


