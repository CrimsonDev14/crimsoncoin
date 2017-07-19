#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

crimsonD=${crimsonD:-$SRCDIR/crimsond}
crimsonCLI=${crimsonCLI:-$SRCDIR/crimson-cli}
crimsonTX=${crimsonTX:-$SRCDIR/crimson-tx}
crimsonQT=${crimsonQT:-$SRCDIR/qt/crimson-qt}

[ ! -x $crimsonD ] && echo "$crimsonD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
DGBVER=($($crimsonCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for crimsond if --version-string is not set,
# but has different outcomes for crimson-qt and crimson-cli.
echo "[COPYRIGHT]" > footer.h2m
$crimsonD --version | sed -n '1!p' >> footer.h2m

for cmd in $crimsonD $crimsonCLI $crimsonTX $crimsonQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${DGBVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${DGBVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
