FROM vladus2000/arch-base
MAINTAINER vladus2000 <docker@matt.land>

COPY shiz/ /

RUN echo >> /etc/pacman.conf && \
	echo '[arcanisrepo]' >> /etc/pacman.conf && \
	echo 'Server = https://repo.arcanis.me/repo/$arch' >> /etc/pacman.conf && \
	pacman -Syyu --noconfirm --needed yay sudo && \
	useradd -G wheel evil && \
	mkdir ~evil && \
	chown evil ~evil && \
	echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
	chmod +x /*.sh && \
	rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

CMD /bin/bash -c /startup.sh
