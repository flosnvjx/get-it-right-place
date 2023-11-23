mkdir d/
mg() {
  local useURI=($(printf %s "$resId" | grep -oEe '((https://|http://|)mega\.(|\.co)nz/(file|#)/[-#0-9A-Za-z!_]+)'))
  if [[ "${#useURI}" -gt 0 ]];then
    megadl --path ./d/ ${useURI[@]}
  else
    false
  fi
}
dm() {
  export PATH=$PATH:$HOME/go/bin
  local useURI="$(printf %s "$resId" | grep -oEe '(https://www\.d.ngm.nm.h.ua\.cn/[^ \t]+)' | tail -n1)"
  if [[ "${#useURI}" -ne 0 ]]; then
    mdl -format=png -out=./d -worker=1 "$useURI"
  else
    false
  fi
}
if test "$resScheme" = mg;then mg
elif test "$resScheme" = dm;then dm
else
  false
fi
if test -n "$resRename";then
  apt install -y icu-devtools
  testfn="$(basename -- "$resRename")"
  if test "${#testfn}" -gt 1 && test "$testfn" != /;then
    export finalFilename="$testfn"
  else
    export finalFilename="$(basename -- "${useURI}")"
  fi
else
  export finalFilename="$(basename -- "${useURI}")"
fi
