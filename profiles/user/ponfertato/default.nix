{ pkgs, ... }:
{
  environment.etc."gitconfig".text = ''
    [user]
      name = ponfertato
      email = ponfertato@ya.ru
    [core]
      excludesFile = /etc/gitignore_global
      editor = nano
    [init]
      defaultBranch = main
    [pull]
      rebase = true
    [push]
      autoSetupRemote = true
    [lfs]
      repositoryformat = 0
  '';

  environment.etc."gitignore_global".text = ''
    *~
    .DS_Store
    .git-credentials
    .idea/
    .vscode/
    node_modules/
  '';

  environment.packages = with pkgs; [
    unstable.lazydocker
    unstable.joplin-desktop
    unstable.neovim
    tmux
  ];

  env.shellInit = ''
    alias nix-od="nix-on-droid switch --flake ~/.config/nixpkgs#$(hostname)"
    alias nix-update="cd ~/.config/nixpkgs && nix flake update"
    alias nix-check="cd ~/.config/nixpkgs && nix flake check"
    alias nix-roll="nix-on-droid switch --rollback"
    alias nix-gc="nix-collect-garbage -d"
    alias ll="ls -lah"
    alias la="ls -A"
    alias ..="cd .."
    alias ...="cd ../.."
    alias gs="git status"
    alias gl="git log --oneline --graph"
    alias gp="git pull --rebase"
  '';
}
