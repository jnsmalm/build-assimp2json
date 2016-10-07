git clone https://github.com/acgessler/assimp2json.git
cd assimp2json
git submodule init; git submodule update

mkdir $env:APPVEYOR_BUILD_FOLDER\assimp2json\b
cd $env:APPVEYOR_BUILD_FOLDER\assimp2json\b
cmake .. -DCMAKE_BUILD_TYPE=Release -DASSIMP_BUILD_TESTS=OFF -DBUILD_SHARED_LIBS=OFF -G "Visual Studio 14 2015" 

msbuild $env:APPVEYOR_BUILD_FOLDER\assimp2json\b\assimp2json.sln /t:Build /p:Configuration=Release

mkdir $env:APPVEYOR_BUILD_FOLDER\dist
Copy-Item $env:APPVEYOR_BUILD_FOLDER\assimp2json\bin\Release\*.exe $env:APPVEYOR_BUILD_FOLDER\dist
Copy-Item $env:APPVEYOR_BUILD_FOLDER\assimp2json\LICENSE $env:APPVEYOR_BUILD_FOLDER\dist

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory("$env:APPVEYOR_BUILD_FOLDER\dist", "$env:APPVEYOR_BUILD_FOLDER\assimp2json-v2.0.1-win.zip", [System.IO.Compression.CompressionLevel]::Optimal, $false)