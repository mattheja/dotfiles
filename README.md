I was inspired by https://github.com/benjifs/dotfiles and  https://news.ycombinator.com/item?id=42234122. I will probably, over time, customize zsh to be more mine and less other peoples.

1. Install git, git-crypt, gpg
2. Add GPG keys from manager, then `gpg --import priv.asc`
3. Add GPG key to git-crypt `git-crypt add-gpg-user $dotfiles_keyid`
4. As needed, add ssh keys, then clone dotfiles repo
5. `git-crypt unlock`
6. Run link script
