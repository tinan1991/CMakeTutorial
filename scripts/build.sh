#!/bin/sh +x

#script dir
script_dir=$(cd "$(dirname "$0")";pwd)
 

#project path
project_dir=$script_dir/..
build_dir=$project_dir/build

cmake -B $build_dir $project_dir \
    -DCMAKE_INSTALL_PREFIX=$build_dir/output\
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_MYMATH

cmake --build $build_dir -j4
cmake --install $build_dir
        '
