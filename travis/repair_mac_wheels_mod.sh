#!\bin/bash

echo "custom wheel repair script" 

wheel_file=$1
dest_dir=$2

echo "wheel file $wheel_file"

mkdir wheel_repair_tmp
cd wheel_repair_tmp
unzip $1 -d .

echo "inside wheel: $(ls ./*)"

cd pytoulbar2/.dylibs

libicuuc=`ls libicuuc*.dylib`
libicui18n=`ls libicui18n*.dylib`
libicudata=`ls libicudata*.dylib`
slibicuuc=${libicuuc%.*}
slibicuuc=${slibicuuc%.*}.dylib
slibicui18n=${libicui18n%.*}
slibicui18n=${slibicui18n%.*}.dylib
slibicudata=${libicudata%.*}
slibicudata=${slibicudata%.*}.dylib

chmod u+w $libicuuc
chmod u+w $libicui18n

install_name_tool -change "@loader_path/$slibicudata" "@loader_path/$libicudata" $libicuuc
install_name_tool -change "@loader_path/$slibicudata" "@loader_path/$libicudata" $libicui18n
install_name_tool -change "@loader_path/$slibicuuc" "@loader_path/$libicuuc" $libicui18n

rm $wheel_file
zip -r ./* -O $dest_dir
cd ..
rm -rf wheel_repair_tmp

