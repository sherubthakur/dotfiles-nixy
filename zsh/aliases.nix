{
  # I don't like the default but my hand just types it
  ":q"="exit";
  vi="nvim";
  vim="nvim";
  top="ytop";
  htop="ytop";
  cat="bat";

  # docker-compose;
  dc="docker-compose";
  dcu="docker-compose up --build";
  dcl="docker-compose logs -f";
  dcisolated="docker-compose up --build --no-deps consul_common common-redis common_db";

  # Navigation;
  "..."="cd ../..";
  "...."="cd ../../..";
  "....."="cd ../../../..";

  # git;
  gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  gc="git commit";
  gca="git commit --amend";
  gdc="git diff --cached";
  gir="git rebase -i";
  gpr="hub pull-request";
  gdpr="hub pull-request --draft";
  gppr="git push origin HEAD && hub pull-request";
  gpdpr="git push origin HEAD && hub pull-request --draft";
  gdlocal="git branch --merged | grep -v '\*' | xargs -n 1 git branch -d";
  gdorigin="git branch -r --merged | grep -v master | sed 's/origin\//:/' | xargs -n 1 -P 5 git push origin";
  gsur="git submodule update --remote";

  # Grep;
  grep="grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}";

  # json formatting;
  json="python -m json.tool";

  # You know (sudoing);
  # If the last character of the value is a blank, then the next command word following the;
  # is also checked for expansion.;
  # So this is just a nice way of making sure your commands are evaluated for aliases before being;
  # passed over to sudo, which ends up being pretty useful.;
  sudo="sudo ";
  fucking="sudo ";
  holdmybeer="sudo ";

  # Serve a folder
  servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'";
}
