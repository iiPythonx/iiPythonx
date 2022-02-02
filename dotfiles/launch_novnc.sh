x11vnc -rfbauth ~/.vnc/passwd -ncache 10 -display :0 -forever -loop -solid &
cd ~/.novnc && ./utils/novnc_proxy --vnc localhost:5900
