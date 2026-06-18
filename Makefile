BUILD_DIR := build

INSTALL_DIR := /usr/local/bin
ifneq ($(shell id -u),0)
	INSTALL_DIR := $(HOME)/.local/bin
endif

.PHONY: install uninstall clean

install: $(BUILD_DIR)/vagari
	install -d $(INSTALL_DIR)
	install -m755 -t $(INSTALL_DIR) $<

$(BUILD_DIR)/vagari: vagari.in
	@mkdir -p $(BUILD_DIR)
	sed 's|@VAGARI_PATH@|$(CURDIR)|g' $< > $@
	@chmod +x $@

uninstall:
	rm -f $(INSTALL_DIR)/vagari

clean:
	rm -rf $(BUILD_DIR)
