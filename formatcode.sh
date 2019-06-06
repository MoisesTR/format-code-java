#!/usr/bin/env sh
changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$")

#numero de archivos a afectar
number_files=$(echo $changed_java_files | wc -w)

GREEN='\033[0;32m'
WHITE='\033[1;37m'

if [ -z "$changed_java_files" ] 
then
    echo "No hay archivos agregados al stage para formatear";
    exit 1
else
    
    echo -e "\nArchivos a formatear: "
    echo -e "======================================================================="
    
    for value in $changed_java_files
    do
        echo -e "${GREEN}$value"
    done

    echo -e "$WHITE======================================================================="

    echo -e "\n======================================================================="
    echo "Se formatearon un total de $number_files archivos"
    echo -e "=======================================================================\n"
    

    if var=$(java -jar .cache/google-java-format-1.7-all-deps.jar --replace $changed_java_files)
    then
        echo "Se han formateado todos los archivos exitosamente."
    else
        echo "Error de sintaxis al formatear"
    fi
    
fi