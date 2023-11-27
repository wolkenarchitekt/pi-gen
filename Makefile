install:
	sudo apt-get install -y \
		coreutils \
		quilt \
		parted \
		qemu-user-static \
		debootstrap \
		zerofree \
		zip \
		dosfstools \
		libarchive-tools \
		libcap2-bin \
		grep \
		rsync \
		xz-utils \
		file \
		git \
		curl \
		bc \
		qemu-utils \
		kpartx \
		gpg \
		pigz \
		qemu-system-x86

clean:
	# Clean
	sudo rm -rf work deploy apt-cacher-ng
	-docker rm -v pigen_work

build:
	# Run apt cache server
	docker compose up -d

	# Build
	./build-docker.sh

write:
	cd deploy && unzip image*.zip
	sudo dd if=deploy/2023-04-11-DockerRaspbian-lite.img of=/dev/sda bs=4M status=progress conv=fdatasync
