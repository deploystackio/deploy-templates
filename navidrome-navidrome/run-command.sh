docker run -d --name navidrome --restart=unless-stopped --user $(id -u):$(id -g) -v /path/to/music:/music -v /path/to/data:/data -p 4533:4533 -e ND_LOGLEVEL=info deluan/navidrome:latest