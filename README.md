G10K
====

G10K is what you get when you combine the ashes of [Powerlevel10K][P10K] with
[Grml][GRML].


## Installation

Using the provided `Makefile`:

```shell
make install
```

Manually:

1. Copy the `g10k-*` files to a directory in your `$fpath`
    1. Alternatively, make a new directory
    2. Add it to the `$fpath`
    3. Copy the `g10k-*` files to the new directory
2. Copy the `g10k.zsh` file to your other zsh dotfiles
3. Source the `g10k.zsh` from your `.zshrc.local`

## Customization

Good luck. Have at. Unsupported.

## Environment

- `G10K_REPORTTIME`: time in seconds for the prompt to show clock time
  of previous command. If unset, uses `$REPORTTIME`. If both are unset, 5.

## Compatibility

This project makes no aims for any compatibility with any other prompt.
This includes, but is not limited to, Powerlevel9k, Powerlevel10k, and
Grml.

This project relies on the Grml prompt functions, but in a future revision
may go purely zsh native.

<!-- --------------------------------------------------------------------- -->

[GRML]: https://grml.org/zsh/ "Zsh"
[P10K]: https://github.com/romkatv/powerlevel10k "A Zsh theme"
