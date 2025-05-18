I'm not quite sure yet, ran out of time, for how to use Oh my zsh here without running the installer script first.

1. Install git, git-crypt, gpg, then https://ohmyz.sh/#install
2. Add GPG keys, then `gpg --import priv.asc`
3. Add GPG key to git-crypt `git-crypt add-gpg-user $dotfiles_id`
4. As needed, add ssh keys, then clone dotfiles repo
5. `git-crypt unlock`
6. Run symlink script
7. `omz reload`
