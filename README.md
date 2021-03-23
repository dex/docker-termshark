# Usage

Use directly: 
```bash
docker run --rm -it --privileged --net host dex0827/termshark [options]
```

Use with tcpdump for applying complex capture filter:
```bash
sudo tcpdump -i <interface> -w - <capture-filter> | docker run --rm -i --privileged -v $(tty):/dev/tty dex0827/termshark --pass-thru=false
```
where `-v $(tty):/dev/tty` is required for obtaining correct TTY to draw terminal UI.

Read pcap file:
```bash
docker run --rm -i --privileged -v $(tty):/dev/tty dex0827/termshark --pass-thru=false < packets.pcap
```
