#!/bin/sh

if [ -z "$RTTY_PATH" ] || [ ! -x "$RTTY_PATH" ]; then
	RTTY_PATH=rtty
fi

tmpdir=/tmp/termshark-$$
export XDG_CACHE_HOME=$tmpdir # this will create per-process cache folder
pcapdir=$tmpdir/termshark/pcaps

if [ -S /var/run/docker.sock ]; then
	docker run --name termshark-$$ -it --net host --privileged dex0827/termshark $*
	docker cp termshark-$$:/root/.cache $tmpdir
	docker rm termshark-$$
elif [ -S /run/k3s/containerd/containerd.sock ]; then
	ctr run -t --net-host --privileged docker.io/dex0827/termshark:latest termshark-$$ termshark $*
	mkdir /tmp/termshark-$$-mnt
	eval $(ctr snapshot mount /tmp/termshark-$$-mnt termshark-$$)
	cp -r /tmp/termshark-$$-mnt/root/.cache $tmpdir
	umount /tmp/termshark-$$-mnt
	rmdir /tmp/termshark-$$-mnt
else
	termshark $*
fi

if [ -d $pcapdir ]; then
	pcap_file=$(ls $pcapdir/*.pcap)
	if [ -f $pcap_file ]; then
		$RTTY_PATH -S $pcap_file
	fi
fi
echo "Clean up cache folder and pcap files"
rm -rf $tmpdir
