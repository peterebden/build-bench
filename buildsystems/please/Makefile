# make magic not needed
export MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

ifndef ROOT_DIR
export ROOT_DIR=$(shell readlink -m $(shell pwd)/../..)
endif

ifndef BUILD_DIR
include $(ROOT_DIR)/include/includes.mk
endif

include $(ROOT_DIR)/include/generators.mk

.PHONY: default
default: please

include $(ROOT_DIR)/include/time.mk
include $(ROOT_DIR)/include/ant.mk

export PLEASE_DIR=$(CACHE_DIR)/please

.PHONY: please
please: please$(PLEASE_DEFAULT_VERSION)

.PHONY: version
version: $(PLEASE_DIR)/please$(PLEASE_DEFAULT_VERSION)/please
	@cd $(PLEASE_DIR); $(PLEASE_DIR)/please$(PLEASE_DEFAULT_VERSION)/please --version

.NOTPARALLEL: please%
.PHONY: please%
please%: $(CONFIGURED_BUILD_ROOT)/please%/PLEASE $(PLEASE_DIR)/please%/please $(REPORTS_DIR)/$(TARGET_NAME).csv
	$(info ******* please start)
	cd $(CONFIGURED_BUILD_ROOT)/please$*; $(PLEASE_DIR)/please$*/please build //:junit //:hamcrest-core
	cd $(CONFIGURED_BUILD_ROOT)/please$*; ANT_HOME=$(ANT_HOME) PATH=$(ANT_IVY_PATH):$(PATH) $(call TIME_CMD,$@) $(PLEASE_DIR)/please$*/please test -p

.PRECIOUS: $(PLEASE_DIR)/%.tar
$(PLEASE_DIR)/%.tar.gz:
	@mkdir -p $(PLEASE_DIR)
	@cd $(PLEASE_DIR); wget --quiet https://get.please.build/linux_amd64/$*/please_$*.tar.gz

.PRECIOUS: $(PLEASE_DIR)/please%/please
$(PLEASE_DIR)/please%/please: $(PLEASE_DIR)/%.tar.gz
	@mkdir -p $(PLEASE_DIR)
	@cd $(PLEASE_DIR); tar -xzf please_$*.tar.gz; mv please please$*
	@cd $(PLEASE_DIR); touch please$*/please

.PRECIOUS: $(CONFIGURED_BUILD_ROOT)/please%/PLEASE
$(CONFIGURED_BUILD_ROOT)/please%/PLEASE: $(CONFIGURED_BUILD_SOURCE)
	@python $(SCRIPTS_DIR)/apply-templates.py $(BUILDTEMPLATES_DIR)/$(BUILD_DEFINITIONS)/please $(CONFIGURED_BUILD_ROOT)/please$* --subprojectnum=$(SUBPROJECT_NUM) --filenum=$(FILE_NUM)
