find  . -type f \( -name '*~' -or -name '.*.sw?' -or -name '*.orig' -or -name '#*#' -or -name '.#*' \) -print -exec rm {} \;
