#!/bin/bash

git clone https://github.com/acgessler/assimp2json.git
cd assimp2json
git submodule init && git submodule update
mkdir b && cd b
cmake .. -DCMAKE_BUILD_TYPE=Release -DASSIMP_BUILD_TESTS=OFF -DBUILD_SHARED_LIBS=OFF && make
cd .. && cd ..

mkdir dist
cp assimp2json/bin/assimp2json ./dist
cp assimp2json/LICENSE ./dist
cd dist && tar -zcvf ../assimp2json-v2.0.1-osx.tar.gz .
cd ..