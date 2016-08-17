#!/bin/shi

lexer=$2
for file in $1
do
  if [[ "$file" =~ "*.case" ]]
  then
    out=`echo $file|sed 's/.case$/.out/g'`
    cat $file | $lexer |diff $out
    if $? != 0
    then
      exit $?
    fi
  fi
done


