# Fedora Postinstall notes

## Clipboard

With Ulauncher we can use [Greenclip Extension](https://ext.ulauncher.io/-/github-kpanuragh-greenclip).

Install:

```sh
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
sudo mv greenclip /usr/local/bin/ 
```

Now, configure the daemon at start:

```bash
mkdir -p .config/autostart
touch greenclip.desktop
```

And use this Desktopfile content:

```
[Desktop Entry]
Type=Application
Name=Greenclip Daemon
Exec=greenclip daemon
X-GNOME-Autostart-enabled=true
Comment=/usr/local/bin/greenclip daemon
```

