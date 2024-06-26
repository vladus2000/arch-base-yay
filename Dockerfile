FROM vladus2000/arch-base
MAINTAINER vladus2000 <docker@matt.land>

COPY shiz/ /

RUN echo >> /etc/pacman.conf && \
	echo '[multilib]' >> /etc/pacman.conf && \
	echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && \
	echo '' >> /etc/pacman.conf && \
	pacman -Syyu --noconfirm --needed debugedit sudo git && \
	useradd -G wheel evil && \
	mkdir ~evil && \
	chown evil ~evil && \
	echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
	chmod +x /*.sh && \
        /install-devel.sh && \
	su - evil -c 'git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm --noprogressbar && cd .. && rm -rf yay' && \
        /rm-devel.sh

CMD /bin/bash -c /startup.sh

