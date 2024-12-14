#!/usr/bin/env bash

for name in content/tex/*.tex
do	
    echo "${name}"
	name=${name##*/}
	name=${name%.*}
    echo "${name}"
	pdflatex -output-directory=content/img content/tex/${name}.tex
	pdf2svg content/img/${name}.pdf content/img/${name}.svg
done

rm content/img/*.aux
rm content/img/*.log
rm content/img/*.pdf
