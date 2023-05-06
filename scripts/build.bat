
@echo off

::script dir
set script_dir=%~dp0
 

::project path
set project_dir=%script_dir%/..
set build_dir=%project_dir%/build

cmake -B %build_dir% %project_dir%^
    -DCMAKE_INSTALL_PREFIX=%build_dir%/output^
    -DCMAKE_BUILD_TYPE=Release^
    -DUSE_MYMATH=ON

::build
::cmake --build %build_dir% -j4
::install
::cmake --install %build_dir% --config Release
        '
