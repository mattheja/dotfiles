I'm not quite sure yet, ran out of time, for how to use Oh my zsh here without running the installer script first.

1. Install git, git-crypt, gpg, then https://ohmyz.sh/#install
2. Add GPG keys from 1Password `gpg --import priv.asc`
3. Add key to git-crypt like `git-crypt add-gpg-user`
4. If needed, add ssh keys, then clone repo
5. `git-crypt unlock`
6. Run symlink script
7. `omz reload`
