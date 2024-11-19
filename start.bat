@echo off
cd "%PROGRAMFILES%\Zapret"
set BLACKLIST="%CD%\hosts.txt"

start "Zapret" /min "%CD%\zapret.exe" ^
--wf-tcp=80,443 --wf-udp=443,50000-65535 ^
--filter-udp=443 --hostlist=%BLACKLIST% --dpi-desync=fake --dpi-desync-udplen-increment=10 --dpi-desync-repeats=6 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic="%CD%\quic.bin" --new ^
--filter-udp=50000-65535 --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --dpi-desync-fake-quic="%CD%\quic.bin" --new ^
--filter-tcp=80 --hostlist=%BLACKLIST% --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist=%BLACKLIST% --dpi-desync=fake,split --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%CD%\tls.bin"

rundll32 url.dll,FileProtocolHandler https://www.youtube.com/feed/subscriptions/