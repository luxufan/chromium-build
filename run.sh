#/bin/sh
find . -iname '*.cc' -printf '%h\000' | sort -z -u | xargs -0 -r ~/dev/chromium-build/replace.sh
