# Usage

Use directly: 
```bash
  docker run --rm -it --privileged --net host dex0827/termshark [options]
```

Use with tcpdump for applying complex capture filter:
```bash
sudo tcpdump -i <interface> -w - <capture-filter> | docker run --rm -i --privileged -v `tty`:/dev/tty dex0827/termshark --pass-thru=false
```
