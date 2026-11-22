FUNCTIONS := $(wildcard g10k-*)
FUNCTIONS_TARGETS = $(addprefix $(G10K_FUNCTION_DIR)/, $(FUNCTIONS))
G10K_FUNCTION_DIR ?= $(G10K_HOME_DIR)/functions
G10K_HOME_DIR ?= ${HOME}/.config/g10k
G10K_ZSH_FILE ?= $(G10K_HOME_DIR)/g10k.zsh
ZSHRC ?= $(or ${ZDOTDIR}, ${HOME})/.zshrc.local

.PHONY: install
install: $(G10K_ZSH_FILE) $(FUNCTIONS_TARGETS) $(ZSHRC)
	@grep -q '$(G10K_ZSH_FILE)' '$(ZSHRC)' \
		|| { printf '[M] Adding g10k theme to %s\n' '$(ZSHRC)';\
		     printf '\n# %s\nsource "%s"\n' \
		       'G10K: Powerlevel10K inspired prompt theme for Grml' \
		       '$(G10K_ZSH_FILE)' \
		     >> '$(ZSHRC)'; }

.PHONY: help menu
help menu:
	@printf 'TARGETS:\n'
	@printf '- install: installs G10K\n'
	@printf '- menu: this menu\n'
	@printf '- help: this menu, galaxy-brain sized\n'
	@printf '%s\n' '----------'
	@printf 'OPTIONS:\n'
	@printf '- G10K_HOME_DIR: where G10K files will live\n'
	@printf '  Default: $$HOME/.config/g10k\n'
	@printf '- G10K_FUNCTION_DIR: where G10K support functions will live\n'
	@printf '  Default: $$(G10K_HOME_DIR)/functions\n'
	@printf '- G10K_ZSH_FILE: location of theme loader\n'
	@printf '  Default: $$(G10K_HOME_DIR)/g10k.zsh\n'
	@printf '- ZSHRC: location of zshrc.local file\n'
	@printf '  Default: $$ZDOTDIR/.zshrc.local or $$HOME/.zshrc.local\n'

$(G10K_ZSH_FILE): g10k.zsh
	@printf '[C] %s -> %s\n' '$<' '$@'
	@install \
		-D \
		-m 0444 \
		g10k.zsh \
		'$@'
	@sed -i -e 's"## FUNCTIONS PATH ##"$(G10K_FUNCTION_DIR)"' '$@'

$(G10K_FUNCTION_DIR)/%: %
	@printf '[C] %s -> %s\n' '$<' '$@'
	@install \
		-D \
		-m 0444 \
		'$<' \
		'$@'

$(ZSHRC):
	@printf '[C] Making empty %s\n' '$@'
	@touch '$@'
