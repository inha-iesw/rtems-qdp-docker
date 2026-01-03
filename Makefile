RTEMS_API = 6
RTEMS_CPU = sparc
RTEMS_BSP = gr740

RTEMS_ROOT = /opt/rtems/6
PKG_CONFIG = $(RTEMS_ROOT)/lib/pkgconfig/$(RTEMS_CPU)-rtems$(RTEMS_API)-$(RTEMS_BSP).pc
BUILDDIR = b-$(RTEMS_BSP)
DEPFLAGS = -MT $@ -MD -MP -MF $(basename $@).d
WARNFLAGS = -Wall -Wextra
OPTFLAGS = -O2 -g -ffunction-sections -fdata-sections -mcpu=leon3 -mfpu -mhard-float
OPTFLAGS_DEBUG = -O0 -g -ffunction-sections -fdata-sections -mcpu=leon3 -mfpu -mhard-float
EXEEXT = .exe

ABI_FLAGS = $(shell pkg-config --cflags $(PKG_CONFIG))
LDFLAGS = $(shell pkg-config --libs $(PKG_CONFIG)) -lrtemsbsp -lrtemstest -lrtemscpu -lm
INCFLAGS = -I/YOUR/INCLUDE_PATH/HERE
CFLAGS = $(DEPFLAGS) $(WARNFLAGS) $(ABI_FLAGS) $(OPTFLAGS)
CFLAGS_DEBUG = $(DEPFLAGS) $(WARNFLAGS) $(ABI_FLAGS) $(OPTFLAGS_DEBUG)
CXXFLAGS = $(DEPFLAGS) $(WARNFLAGS) $(ABI_FLAGS) $(OPTFLAGS)
ASFLAGS = $(ABI_FLAGS)

CCLINK = $(CC) $(CFLAGS) -Wl,-Map,$(basename $@).map
CXXLINK = $(CXX) $(CXXFLAGS) -Wl,-Map,$(basename $@).map

export PATH := $(RTEMS_ROOT)/bin:$(PATH)

export AR = $(RTEMS_CPU)-rtems$(RTEMS_API)-ar
export AS = $(RTEMS_CPU)-rtems$(RTEMS_API)-as
export CC = $(RTEMS_CPU)-rtems$(RTEMS_API)-gcc
export CXX = $(RTEMS_CPU)-rtems$(RTEMS_API)-g++
export LD = $(RTEMS_CPU)-rtems$(RTEMS_API)-ld
export NM = $(RTEMS_CPU)-rtems$(RTEMS_API)-nm
export OBJCOPY = $(RTEMS_CPU)-rtems$(RTEMS_API)-objcopy
export RANLIB = $(RTEMS_CPU)-rtems$(RTEMS_API)-ranlib
export SIZE = $(RTEMS_CPU)-rtems$(RTEMS_API)-size
export STRIP = $(RTEMS_CPU)-rtems$(RTEMS_API)-strip

APP = $(BUILDDIR)/app
APP_C_FILES =
APP_C_FILES += YOUR_C_SOURCES_HERE

APP_OBJS = $(APP_C_FILES:%.c=$(BUILDDIR)/%.o) $(UTILS_OBJS)
APP_DEPS = $(APP_C_FILES:%.c=$(BUILDDIR)/%.d) $(UTILS_DEPS)

$(BUILDDIR)/%.o: %.c | $(BUILDDIR)
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.S | $(BUILDDIR)
	$(CC) $(INCFLAGS) $(CPPFLAGS) -DASM $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.cc | $(BUILDDIR)
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.cpp | $(BUILDDIR)
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.s | $(BUILDDIR)
	$(AS) $(ASFLAGS) $< -o $@

all: $(APP)$(EXEEXT)

$(BUILDDIR):
	mkdir $(BUILDDIR)

$(APP)$(EXEEXT): $(APP_OBJS)
	$(CCLINK) $^ $(LDFLAGS) -o $@

run: $(APP)$(EXEEXT)
	laysim-gr740-cli -r -core0 $<

clean:
	rm -rf $(BUILDDIR)

-include $(APP_DEPS)