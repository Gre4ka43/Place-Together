# Place Together

A custom plugin for Roblox Studio to enable collaborative game development (similar to Team Create) via local network connections.

## Getting Started

### 1. Download Place Together

Download the latest release from the [Releases](https://github.com/Gre4ka43/Place-Together/releases) page.

You will need:

- **Place Together plugin** (`.rbxmx` file) - to install it in Roblox Studio.
- **Server launcher** - the `.bat` file used to start the Place Together server.

---

### 2. Install the Plugin

The easiest way to install everything is to open **Roblox Studio**, go to the **Plugins** tab, and click **Plugin Folder**. 
Extract both the `.rbxmx` plugin file and the server `.bat` files into this folder to keep everything in one place.

After installation, restart Roblox Studio if the plugin does not appear immediately on your toolbar.

> **⚠️ IMPORTANT:** Upon first use, Roblox Studio may ask for permission to allow **HTTP Requests** and **Script Injection** for Place Together. You **MUST** click 'Allow', otherwise the plugin will not function and cannot sync your project.

---

### 3. Connect Everyone to the Same Network

Place Together currently requires all participants to be able to connect to the host's computer.

The easiest way is to use a virtual LAN/networking application. You can use any of these:

- [Radmin VPN](https://www.radmin-vpn.com/) — creates a virtual local network between participants.
- [Hamachi](https://vpn.net/) — another popular virtual LAN solution.
- [Porthole - Local Port Sharing](https://store.steampowered.com/app/4963920/Porthole_Local_Port_Sharing/) — a newer alternative that can make local services accessible to your friends without port forwarding.

**Everyone who wants to participate should join the same virtual network/lobby.**

---

### 4. Check Windows Firewall

Windows Firewall may prevent other players from connecting to the Place Together server.

If you cannot connect, check your Windows Firewall settings and allow the server through the firewall.

For testing, you can temporarily disable Windows Firewall, but **this is not recommended for normal use**. It is safer to create a firewall rule allowing the required server application/port.

Make sure you only do this on a network and with people you trust. *(Don't forget to turn the firewall back on after you finish working!)*

---

### 5. Start the Server

The person hosting the session should run the provided `.bat` file.

A console window will open and start the Place Together server.

After the server starts, **the console will explicitly display an IP address**.

Copy this IP address from the console and send it to the people who want to connect.

> **Important:** The IP displayed by the server console is the exact address that both the host and other participants need to enter in the Place Together plugin settings.

---

### 6. Connect to the Server

The player who wants to join should:

1. Open Roblox Studio.
2. **Open an empty Baseplate.** 
   > **⚠️ WARNING:** When joining someone else's session, *always* open an empty Baseplate. Do not open your existing local places, as their contents will be overwritten and mixed with the host's map.
3. Open the **Place Together** plugin.
4. Open the plugin settings.
5. Enter the **IP address displayed in the host's server console**.
6. Connect to the server.

Make sure the player is connected to the same virtual network as the host.

---

### 7. Invite Each Other

Once connected to the server, use the Place Together plugin (as the Host) to **invite other players by their Roblox username**.

Players can then accept and join the collaborative session through the invitation.

---

### 8. Connection Problems

If the connection does not work, check the following:

- Everyone is connected to the same virtual network.
- The host is running the `.bat` server.
- The IP address entered in the plugin is exactly the IP displayed by the server console.
- Windows Firewall is not blocking the server.
- Everyone is using the same version of Place Together.

#### Try switching the host

Sometimes a connection may not work correctly **from the host to another player** due to NAT types or ISP restrictions.

If this happens, try having the other player **host the server instead** and invite the original host.

For example:

**Host A → Player B doesn't work**

Try:

**Host B → Player A**

The connection may work perfectly in the opposite direction depending on your specific network configuration.

---

## ⚠️ Early Development & Limitations ⚠️

Place Together is still in early development. 

**Currently Supported:** 
- Parts creation, movement, and editing
- Terrain generation and editing
- GUI synchronization
- Script synchronization
- Toolbox assets loading

**Current Limitations & Known Issues:**
- Team Test is currently **not** supported.
- **Simultaneous Script Editing:** If two people edit the exact same script at the same time, the later save will overwrite the other developer's changes. Please edit different scripts or communicate before modifying code.

You may also encounter:
- Bugs and crashes
- Connection problems or synchronization delays depending on your network
- Unexpected behavior

If you encounter a problem, please report it through the GitHub repository's **Issues** tab (including the error text from the server console) so it can be investigated and fixed.
