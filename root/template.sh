#!/bin/bash

function template () {
  infile=${1}
  OUTDIR=${3}
  tmpfile=${infile}.tmp
  if [ -n "${OUTDIR}" ]; then
    outfile=${OUTDIR}/`basename ${infile}`
  else
    outfile=$infile
    ARGS='$PROXY_PASS_URL'
  fi
  echo "Templating ${infile} and saving as ${outfile}"
  sed "s/{{ .Env.\([a-zA-Z0-9_-]*\) }}/\${\1}/" < ${infile} > ${tmpfile}
  envsubst "$ARGS" < ${tmpfile} > $outfile
  rm ${tmpfile}
  echo ""
  echo "----------------"
  cat $outfile
  echo "----------------"
  echo ""
}

if [ -f $1 ]; then
  template $1 $2
fi

if [ -d $1 ]; then
  OUTDIR="$1/_config"
  INDIR="$1/config"
  mkdir -p ${OUTDIR}

  for infile in $INDIR/*; do
    template ${infile} $2 ${OUTDIR}
  done
fi



rm -rf $INDIR

