set shell := ["bash", "-euo", "pipefail", "-c"]

flathub_remote := "https://dl.flathub.org/repo/flathub.flatpakrepo"

chat_apps := "com.discordapp.Discord org.signal.Signal org.localsend.localsend_app"
media_apps := "com.github.iwalton3.jellyfin-media-player"
browser_apps := "app.zen_browser.zen"
notes_apps := "md.obsidian.Obsidian"
cloud_apps := "com.nextcloud.desktopclient.nextcloud"
mail_apps := "me.proton.Mail"
music_apps := "org.musicbrainz.Picard"
design_apps := "org.freecad.FreeCAD org.blender.Blender"

all_apps := chat_apps + " " + media_apps + " " + browser_apps + " " + notes_apps + " " + cloud_apps + " " + mail_apps + " " + music_apps + " " + design_apps

default: install

configure-git:
    git config --global user.email "36940948+camwolff02@users.noreply.github.com"
    git config --global user.name "cam"

ensure-flathub:
    flatpak remote-add --if-not-exists flathub {{flathub_remote}}
    flatpak update --appstream --noninteractive || true

install: ensure-flathub
    for app in {{all_apps}}; do \
        echo "Installing $app"; \
        flatpak install --system --assumeyes flathub "$app"; \
    done

install-chat: ensure-flathub
    for app in {{chat_apps}}; do \
        flatpak install --system --assumeyes flathub "$app"; \
    done

install-design: ensure-flathub
    for app in {{design_apps}}; do \
        flatpak install --system --assumeyes flathub "$app"; \
    done
