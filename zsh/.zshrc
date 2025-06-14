# Basic zsh configuration

export ZSH_THEME=bnj

# To sign commits with GPG
export GPG_TTY=$(tty)

for alias in $HOME/.config/*aliases; do
	[ -f "$alias" ] && source "$alias"
done

for file in $HOME/.config/zsh/*.zsh; do
	source "$file"
done

if [ "$TERM" = "linux" ]; then
#	printf "\033]P0262626"
	printf "\033]P0131415"
	printf "\033]P1f55678"
	printf "\033]P26ef596"
	printf "\033]P3f7f086"
	printf "\033]P471a8fe"
	printf "\033]P5f27b92"
	printf "\033]P656c7f5"
	printf "\033]P7ededed"
	printf "\033]P8666666"
	printf "\033]P9f66e8b"
	printf "\033]Pa86f7a7"
	printf "\033]Pbf9f39e"
	printf "\033]Pc8ab8fe"
	printf "\033]Pdf492a5"
	printf "\033]Pe6ecff6"
	printf "\033]Pfffffff"
fi

# Need to add these to PATH in .zshrc
# otherwise, default values get prepended
# which ignores these
if type brew &>/dev/null; then
	export PATH="$(brew --prefix)/opt/ruby/bin:$(brew --prefix)/opt/mysql@8.0/bin:$PATH"
fi

# Go path via brew by default
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"
