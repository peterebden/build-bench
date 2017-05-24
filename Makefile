# make magic not needed
export MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

# only works when running make in root folder :-(
export ROOT_DIR=$(shell pwd)

.PHONY: default
default: all


# load config files to set variables
include $(ROOT_DIR)/include/includes.mk


.PHONY: all
all: $(BUILDSYSTEMS)

include $(ROOT_DIR)/include/generators.mk

# copy project sources into buildsystem subdir
.PRECIOUS: $(CONFIGURED_BUILD_ROOT)/%/src
$(CONFIGURED_BUILD_ROOT)/%/src: $(CONFIGURED_BUILD_SOURCE)
ifndef TARGET_NAME
	$(error TARGET_NAME is not set, defines where files are to be generated to)
endif
	@mkdir -p $(CONFIGURED_BUILD_ROOT)/$*
	cd $(CONFIGURED_BUILD_ROOT)/$*; cp -rf $(CONFIGURED_BUILD_SOURCE)/* .
# touch folder so that this step can be skipped next time
	@touch $(CONFIGURED_BUILD_ROOT)/$*/src


# invoke specific buildsystem version. TODO: Find out how to generify this with makefile

.PHONY: gradle
gradle:gradle$(GRADLE_DEFAULT_VERSION)

.PHONY: gradle%
gradle%: $(CONFIGURED_BUILD_ROOT)/gradle%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/gradle $@


.PHONY: ant_ivy
ant_ivy:ant_ivy$(ANT_DEFAULT_VERSION)

.PHONY: ant_ivy%
ant_ivy%: $(CONFIGURED_BUILD_ROOT)/ant_ivy%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/ant_ivy $@


.PHONY: maven
maven:maven$(MAVEN_DEFAULT_VERSION)

.PHONY: maven%
maven%: $(CONFIGURED_BUILD_ROOT)/maven%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/maven $@


.PHONY: buildr
buildr:buildr$(BUILDR_DEFAULT_VERSION)

.PHONY: buildr%
buildr%: $(CONFIGURED_BUILD_ROOT)/buildr%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/buildr $@


.PHONY: buck
buck:buck$(BUCK_DEFAULT_VERSION)

.PHONY: buck%
buck%: $(CONFIGURED_BUILD_ROOT)/buck%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/buck $@


.PHONY: sbt
sbt:sbt$(SBT_DEFAULT_VERSION)

.PHONY: sbt%
sbt%: $(CONFIGURED_BUILD_ROOT)/sbt%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/sbt $@


.PHONY: leiningen
leiningen:leiningen$(LEININGEN_DEFAULT_VERSION)

.PHONY: leiningen%
leiningen%: $(CONFIGURED_BUILD_ROOT)/leiningen%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/leiningen $@


.PHONY: lein-sub
lein-sub:lein-sub$(LEININGEN_DEFAULT_VERSION)

.PHONY: lein-sub%
lein-sub%: $(CONFIGURED_BUILD_ROOT)/lein-sub%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/lein-sub lein-sub$*


.PHONY: bazel
bazel:bazel$(BAZEL_DEFAULT_VERSION)

.PHONY: bazel%
bazel%: $(CONFIGURED_BUILD_ROOT)/bazel%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/bazel $@


.PHONY: pants
pants:pants$(PANTS_DEFAULT_VERSION)

.PHONY: pants%
pants%: $(CONFIGURED_BUILD_ROOT)/pants%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/pants $@


.PHONY: please
please:please$(PLEASE_DEFAULT_VERSION)

.PHONY: please%
please%: $(CONFIGURED_BUILD_ROOT)/please%/src
	$(MAKE) -C $(BUILDSYSTEMS_DIR)/please $@


.PHONY: versions
versions:
	java -version
	$(foreach LOOP_SYSTEM,$(BUILDSYSTEMS),$(MAKE) -C $(BUILDSYSTEMS_DIR)/$(LOOP_SYSTEM) version;)
