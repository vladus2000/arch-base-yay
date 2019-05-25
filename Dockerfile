FROM vladus2000/arch-base
MAINTAINER vladus2000 <docker@matt.land>

COPY shiz/ /

RUN echo >> /etc/pacman.conf && \
	echo '[vladus2000]' >> /etc/pacman.conf && \
	echo 'Server = https://repo.matt.land/$repo/$arch' >> /etc/pacman.conf && \
	echo 'SigLevel = PackageOptional' >> /etc/pacman.conf && \
	pacman -Syyu --noconfirm --needed yay sudo git && \
	useradd -G wheel evil && \
	mkdir ~evil && \
	chown evil ~evil && \
	echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
	chmod +x /*.sh && \
	rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

CMD /bin/bash -c /startup.sh
