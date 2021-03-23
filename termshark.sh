#!/bin/sh

if [ -z "$RTTY_PATH" ] || [ ! -x "$RTTY_PATH" ]; then
	RTTY_PATH=rtty
fi

tmpdir=/tmp/termshark-$$
export XDG_CACHE_HOME=$tmpdir # this will create per-process cache folder
pcapdir=$tmpdir/termshark/pcaps

#termshark $*
docker run --name termshark-$$ -it --net host --privileged --env TERM=xterm-256color docker-termshark $*
docker cp termshark-$$:/root/.cache $tmpdir
docker rm termshark-$$

if [ -d $pcapdir ]; then
	pcap_file=$(ls $pcapdir/*.pcap)
	if [ -f $pcap_file ]; then
		$RTTY_PATH -S $pcap_file
	fi
fi
echo "Clean up cache folder and pcap files"
rm -rf $tmpdir
