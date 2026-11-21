# replicating Powerlevel 10K (lean) in GRML

fpath+=~/.g10k/functions
autoload -Uz ${fpath[-1]}/*(:t)

preexec_functions+=g10k-preexec-time
precmd_functions=(g10k-save-status $precmd_functions)

# colors! https://www.ditig.com/publications/256-colors-cheat-sheet

# add iterm2 mark token
if typeset -f iterm2_prompt_mark; then
  grml_theme_has_token iterm2_mark \
    || grml_theme_add_token iterm2_mark "$(iterm2_prompt_mark)" '%{' '%}'
else
  grml_theme_has_token iterm2_mark \
    || grml_theme_add_token iterm2_mark '' '' ''
fi
grml_theme_has_token os \
  || grml_theme_add_token os -i g10k-os '' ''
grml_theme_has_token shlvl \
  || grml_theme_add_token shlvl -f g10k-shlvl '%F{69}' '%f'
grml_theme_has_token job_count \
  || grml_theme_add_token job_count '%(1j,  %j,)' '%F{70}' '%f' #p10k lacks count
grml_theme_has_token exec_time \
  || grml_theme_add_token exec_time -f g10k-exec-time '%F{101}' '%f'
grml_theme_has_token virtualenv \
  || grml_theme_add_token virtualenv -f g10k-virtualenv '%F{37}' '%f'
grml_theme_has_token path_token \
  || grml_theme_add_token path_token -f g10k-path-icon '%F{31}' '%f'
grml_theme_has_token path_trunc \
  || grml_theme_add_token path_trunc -f g10k-path '' ''
grml_theme_has_token ssh_user \
  || grml_theme_add_token ssh_user -f g10k-ssh-user '%F{180}' '%f'
grml_theme_has_token status \
  || grml_theme_add_token status '%(?,, %F{160}✘ %(130?,INT,%?)%f)' '' ''
grml_theme_has_token pipestatus \
  || grml_theme_add_token pipestatus -f g10k-pipestatus '%F{199}' '%f'
typeset -gA _signames
() {
  local _index
  for ((_index=1;_index<=$#signals;++_index)) {
    _g10k_signames[$((127+_index))]=$signals[$_index]
  }
}

zstyle ':prompt:grml:left:setup' items \
	os \
	path_token \
	path_trunc \
	vcs \
	newline \
	iterm2_mark \
	percent
zstyle ':prompt:grml:right:setup' items \
	change-root \
	pipestatus \
	exec_time \
	job_count \
	shlvl \
	virtualenv \
	ssh_user

# colors need verified; pulled from STATUS_OK / STATUS_ERROR
grml_prompt_pre_default[percent]='%(?.%F{70}.%F{160})'
grml_prompt_token_default[percent]='❯ '
grml_prompt_post_default[percent]='%b%f%k%s%u'

# truncate long paths more fancily
# still needs proper coloration
grml_prompt_pre_default[path]='%F{31}'
grml_prompt_token_default[path]='%(5~|%-1~/…/%3~|%4~) '
grml_prompt_post_default[path]='%f'

## VCS
autoload -U colors && colors # probably already done
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

# as set with p10k
# zstyle ':vcs_info:svn*:*' actionformats '%c%u %F{1}| %a%f'
zstyle ':vcs_info:*' actionformats '%b %F{1}| %a%f'
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%F{yellow}%r'
# zstyle ':vcs_info:hg*:*' branchformat ' %b'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:svn*:*' formats %c%u
zstyle ':vcs_info:git*' formats $'%{\C-[[36m%}[%{\C-[[34m%}%b%{\C-[[33m%}%m%u%c%{\C-[[36m%}]%{\C-[[00m%}'
zstyle ':vcs_info:*' formats %b%c%u%m
# zstyle ':vcs_info:hg*:*' get-bookmarks true
# zstyle ':vcs_info:hg*:*' get-revision true
zstyle ':vcs_info:*' get-revision false
zstyle ':vcs_info:git*+set-message:*' hooks vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname
# zstyle ':vcs_info:hg*+set-message:*' hooks vcs-detect-changes
# zstyle ':vcs_info:svn*+set-message:*' hooks vcs-detect-changes svn-detect-changes
# zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
zstyle ':vcs_info:*' max-exports 2
zstyle ':vcs_info:*' stagedstr '  '
zstyle ':vcs_info:*' unstagedstr '  '


alias prompt-reload='source ~/.zsh.d/zshrc.d/65-grml-p10k && echo "Prompt reloaded"'

# TODO:
# https://vincent.bernat.ch/en/blog/2021-zsh-transient-prompt
