# PlaceTogether

PlaceTogether is a self-hosted collaboration plugin for Roblox Studio. Work on a shared place with friends over a local network or VPN. One person runs the server, and everyone installs the Studio plugin.

## Download

Choose the package for the **server host's operating system**. Each clean package includes `PlaceTogether.rbxmx`, the server launcher, and a short setup guide. [Releases](https://github.com/Gre4ka43/Place-Together/releases)

| Host OS | Server launcher | Requirements |
|---|---|---|
| Windows | `PlaceTogetherServerDesktop.exe` | Runs without installing Python |
| Linux | `python3 PlaceTogetherServer.pyz` | Python 3.12 or newer, Tk, and a graphical session |
| macOS | `PlaceTogether Server.app` | Python 3.12 or newer with Tk |

The Linux and macOS packages require Python on the host. Roblox Studio and the plugin are required on each editing computer.

## Set up a session

### 1. Install the plugin

In Roblox Studio, open **Plugins → Plugin Folder** and copy `PlaceTogether.rbxmx` into that folder. Restart Studio and open **PlaceTogether** from the Plugins toolbar. Keep the server files in their own folder.

When Studio asks for permission, allow HTTP requests so the plugin can reach your server. Allow script injection if you want to synchronize script contents.

### 2. Start the server

The host opens the server app, clicks **Start**, and leaves it running. The **Connection** tab shows the IP addresses and port. Use **Copy** next to a value or select the text and copy it.

| Who is connecting | IP / Host in plugin Settings |
|---|---|
| Host, on the same computer as the server | `127.0.0.1` |
| Teammate, on another computer | The host's IP on your shared LAN or VPN |

Enter the port shown in the server app. The default is `8787`. If the host configured a server password, everyone enters it in the plugin's **Settings**.

### 3. Host and join by room code

**Standard session.** The host opens the place to share and chooses **Together → Host New Session**. Once the room is ready, copy its room code and send it to your teammates. Each teammate opens a fresh Baseplate, enters the code under **Together**, and chooses **Join by Room Code**. Keep a separate local copy of any place you want to preserve.

**Same Copy.** Use this when everyone already has the same saved copy of the place. The host chooses **Host Same Copy** and teammates open their matching copies and choose **Join Same Copy** with the room code. This skips the initial map transfer. Large places may still need time to index local objects. The progress display shows the current stage and object count.

## What you can do

- Sync edits to supported objects, including parts, GUI, scripts, and Terrain.
- See teammate presence and supported live drag updates during editing.
- Open the **Team Test** tab for a shared walkthrough with R6 characters. Walkthrough runs in Edit mode and supports movement, camera controls, and collisions. Game scripts and Roblox server physics require a separate Studio playtest.

PlaceTogether is in early development. Save local copies of important places. Coordinate edits when working on the same script because overlapping changes may need to be resolved manually.

## Troubleshooting

- **A teammate cannot connect.** Check that the server is running and both computers can reach each other over the same LAN or VPN. Verify the host IP, port, and password in **Settings**. On Windows, allow the server or its TCP port through the firewall for the network you are using.
- **A room is still preparing.** Wait for the host to finish uploading or indexing the place. For a large place that everyone already has, use **Same Copy**.
- **The plugin is missing or cannot sync.** Restart Studio, check the plugin permissions, and confirm everyone is using the same plugin version.

For bug reports, include your operating system, plugin version, steps to reproduce, and relevant Studio Output or server logs. Export server logs from **Logs → Export TXT**. [Issues](https://github.com/Gre4ka43/Place-Together/issues)
