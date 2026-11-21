FUNCTIONS := $(wildcard g10k-*)
FUNCTIONS_TARGETS = $(addprefix $(G10K_FUNCTION_DIR)/, $(FUNCTIONS))
G10K_FUNCTION_DIR ?= $(G10K_HOME_DIR)/functions
G10K_HOME_DIR ?= ${HOME}/.g10k
G10K_ZSH_FILE ?= $(G10K_HOME_DIR)/g10k.zsh
ZSHRC ?= $(or ${ZDOTDIR}, ${HOME})/.zshrc.local

.PHONY: install
install: $(G10K_ZSH_FILE) $(ZSHRC) $(FUNCTIONS_TARGETS)
	@grep -q g10k.zsh $(ZSHRC) \
		|| { printf '[M] Adding g10k.zsh to %s\n' "$(ZSHRC)";\
		     printf '\n# g10k\nsource "%s"\n' \
		       "$(G10K_HOME_DIR)/g10k.zsh" \
		     >> "$(ZSHRC)"; }

$(G10K_ZSH_FILE): g10k.zsh
	@printf '[C] %s -> %s\n' "$<" "$@"
	@install \
		-D \
		--mode=0444 \
		g10k.zsh \
		"$@"

$(G10K_FUNCTION_DIR)/%: %
	@printf '[C] %s -> %s\n' '$<' '$@'
	@install \
		-D \
		-m 0400 \
		'$<' \
		'$@'

$(ZSHRC):
	@printf '[C] Making empty %s\n' "$@"
	@install \
		-D \
		-m 0644 \
		/dev/null \
		"$@"
