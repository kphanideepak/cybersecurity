#!/bin/bash

# this script helps to create a bash script file with exec bit set along with shabng

script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

if [[ $# -le 0 || $1 == "--help" ]]; then
        echo -e $(tput setaf 3)USAGE:$NC $script_name filename [file extension]
        exit 2
fi

case $2 in 
        sh)
        ext="sh";
        sb="bash";
        ;;
        py)
        ext="py";
        sb="python";
        ;;
        *)
        ext="sh";
        sb="bash";
        ;;
esac

filename=$1.$ext

echo "creating $filename .."
touch $filename
chmod 755 $filename
echo "#!/bin/"$sb> $filename
ls -l $filename