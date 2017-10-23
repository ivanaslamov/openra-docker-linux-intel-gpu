FROM ubuntu

RUN apt-get update
RUN apt-get -y install wget pulseaudio xdg-utils libxss1

# audio video related setup
RUN echo enable-shm=no >> /etc/pulse/client.conf
RUN groupadd -f -g 1000 game
RUN adduser --uid 1000 --gid 1000 --disabled-login --gecos 'Game' game

ENV DISPLAY=:0
ENV PULSE_SERVER /run/pulse/native

# game dependencies
RUN apt-get -y install ubuntu-mono mono-runtime libmono-system-core4.0-cil libmono-system-drawing4.0-cil libmono-system-drawing4.0-cil libmono-system-data4.0-cil libmono-system-numerics4.0-cil libmono-system-runtime-serialization4.0-cil libmono-system-xml-linq4.0-cil libmono-i18n4.0-all xdg-utils zenity libsdl2-dev liblua5.1-0  libalut-dev tzdata

# game setup
RUN wget -O openra.deb https://github.com/OpenRA/OpenRA/releases/download/release-20170527/openra_release.20170527_all.deb
RUN dpkg -i openra.deb
RUN apt-get -y -f install

# store local game data
ADD .openra /home/user/.openra

USER game

CMD /usr/games/openra
