pushd "%~dp0"
pushd "a2e"
set TGT=MouseNoAway
ahk2exe /in ..\%TGT%.ahk /icon ..\%TGT%.ico
popd
popd
