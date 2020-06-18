{
  # I don't like the default but my hand just types it
  ":q"="exit";
  vi="nvim";
  vim="nvim";
  top="ytop";
  htop="ytop";
  ytop="ytop --per-cpu --battery --statusbar";
  cat="bat";

  # docker-compose;
  dc="docker-compose";
  dcu="docker-compose up --build";
  dcl="docker-compose logs -f";
  dcisolated="docker-compose up --build --no-deps consul_common common-redis common_db";

  # Navigation;
  ".."="cd ..";
  "..."="cd ../..";
  "...."="cd ../../..";
  "....."="cd ../../../..";

  # git;
  gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  gc="git commit";
  gs="git status";
  gca="git commit --amend";
  gd="git diff";
  gdc="git diff --cached";
  gir="git rebase -i";
  gpr="hub pull-request";
  gdpr="hub pull-request --draft";
  gppr="git push origin HEAD && hub pull-request";
  gpdpr="git push origin HEAD && hub pull-request --draft";
  gsur="git submodule update --remote";

  # Grep;
  grep="grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}";

  # json formatting;
  json="python -m json.tool";

  # You know (sudoing);
  # If the last character of the value is a blank, then the next command word following
  # the; is also checked for expansion.; So this is just a nice way of making sure your
  # commands are evaluated for aliases before being; passed over to sudo, which ends
  # up being pretty useful.;
  sudo="sudo ";
  fucking="sudo ";
  holdmybeer="sudo ";

  # Serve a folder
  servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'";
}
