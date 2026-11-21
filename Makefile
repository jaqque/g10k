FUNCTIONS := $(wildcard g10k-*)
G10K_FUNCTIONS ?= $(G10K_HOME)/functions
G10K_HOME ?= ${HOME}/.g10k
G10K_ZSH ?= $(G10K_HOME)/g10k.zsh
ZSHRC ?= $(or ${ZDOTDIR}, ${HOME})/.zshrc.local

.PHONY: install
install: $(G10K_ZSH) $(ZSHRC)
	@printf '[C] g10k -> %s\n' "$(G10K_FUNCTIONS)"
	@install \
		-D \
		--mode=0444 \
		--target-directory="$(G10K_FUNCTIONS)" \
		$(FUNCTIONS)
	@grep -q g10k.zsh $(ZSHRC) \
		|| { printf '[M] Adding g10k.zsh to %s\n' "$(ZSHRC)";\
		     printf '\n# g10k\nsource "%s"\n' "$(G10K_HOME)/g10k.zsh" \
		     >> "$(ZSHRC)"; }

$(G10K_ZSH): g10k.zsh
	@printf '[C] %s -> %s\n' "$<" "$A"
	@install \
		-D \
		--mode=0444 \
		g10k.zsh \
		"$@"

# $(FUNCTIONS):

$(ZSHRC):
	@printf '[C] Makign empty %s\n' "$@"
	@install \
		-D \
		--mode=0644 \
		/dev/null \
		"$@"

