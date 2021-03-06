#!/bin/bash

# This script reindents a file using emacs-style indentation,
# with no indentation in namespaces.
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 file.C"
    exit 1
fi

# You can specify what Emacs to use whe you run this script with e.g.
#
# EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs reindent.sh foo.C
#
# otherwise /usr/bin/emacs will be used.  The /usr/bin/emacs on OSX is
# very old (circa 2007 22.1.1 on Yosemite in 2015) and there are some
# bugs in the way that it indents C++ code, so we definitely recommend
# using something newer if possible.
if [ -z $EMACS ]; then
  EMACS=/usr/bin/emacs
fi

# Even the most recent version of Emacs (25.1.50.1 at the time of this
# writing) fails to properly indent classes which have been marked
# "libmesh_final", presumably because this is our own macro which is
# not valid C++.  It does, however, properly indent classes marked as
# "final".  So, a possible workaround is to text-replace
# "libmesh_final" with "final" before doing the indentation, and then
# swap it back again afterward.
perl -pli -e 's/ libmesh_final : / final : /g' $1

# Print name of file we are working on
echo "Indenting $1"

# The following command:
# .) Uses only spaces for tabs
# .) Forces emacs to use C++ mode
# .) Sets the indentation level within namespaces to 0
# .) Runs indent-region on the entire file
# .) Saves the buffer
$EMACS -batch $1  \
  --eval="(setq-default indent-tabs-mode nil)" \
  --eval="(c++-mode)" \
  --eval="(c-set-offset 'innamespace 0)" \
  --eval="(indent-region (point-min) (point-max) nil)" \
  -f save-buffer &> /dev/null

perl -pli -e 's/ final : / libmesh_final : /g' $1

# Local Variables:
# sh-basic-offset: 2
# sh-indentation: 2
# End:
