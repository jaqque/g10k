FUNCTIONS := $(wildcard g10k-*)
G10K_FUNCTIONS ?= $(G10K_HOME)/functions
G10K_HOME ?= ${HOME}/.g10k
G10K_ZSH ?= $(G10K_HOME)/g10k.zsh
ZSHRC ?= $(or ${ZDOTDIR}, ${HOME})/.zshrc.local

.PHONY: install
install: $(G10K_ZSH) $(ZSHRC)
	# @cp -a ${FUNCTIONS} "$(G10K_FUNCTIONS)"
	install \
		-D \
		--mode=0444 \
		--target-directory="$(G10K_FUNCTIONS)" \
		$(FUNCTIONS)
	grep -q g10k.zsh $(ZSHRC) \
		|| { printf '\n# g10k\nsource "%s"\n' "$(G10K_HOME)/g10k.zsh" \
		>> "$(ZSHRC)"; }

$(G10K_ZSH): g10k.zsh
	install \
		-D \
		--mode=0444 \
		g10k.zsh \
		"$@"

# $(FUNCTIONS):

$(ZSHRC):
	install \
		-D \
		--mode=0644 \
		/dev/null \
		"$@"

