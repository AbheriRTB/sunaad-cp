#! /bin/sh

cd sunaad

flutter --enable-web
flutter build web

cd ..
ln -s sunaad/build/web/index.html index.html

echo "build completed..."



