#!/bin/bash

# A simple shell script to replace the default color in the footerscroll.svg
# file with an override value, and generate a temporary version of the
# footer PDF.
BASEDIR=$(dirname "$0")
FOOTERFILE=footerscroll.svg
TEMPFILE=temp${FOOTERFILE}

# Use the first command line parameter as a hex color string (RRGGBB).
color=$1
if [ -z "${color}" ]; then
  echo Color parameter not set, using default \(deca82\)
  color="deca82"
fi

# Create temporary copy of the svg file.
cp -p $BASEDIR/src/${FOOTERFILE} ${BASEDIR}/${TEMPFILE}

# Replace the default color with the option parameter.
# NOTE: Obviously this will only work if the default color is never changed...
sed -i 's/deca82/'${color}'/g' ${BASEDIR}/${TEMPFILE}

# Use inkscape to regenerate the footer PDF.
inkscape -z ${BASEDIR}/${TEMPFILE} --export-type=pdf -o ${BASEDIR}/themed-footerscroll.pdf

# Clean up
rm ${BASEDIR}/${TEMPFILE}

