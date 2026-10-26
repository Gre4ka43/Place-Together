## Getting Started

### 1. Download the Files

Download the latest version from the [Releases](https://github.com/Gre4ka43/Place-Together/releases) page.

### 2. Install the Plugin

Install the Place Together plugin in Roblox Studio using the provided plugin file.

### 3. Set Up a Virtual LAN

All participants must be connected to the same virtual local network. You can use one of the following tools:

- [Radmin VPN](https://www.radmin-vpn.com/)
- [Hamachi](https://vpn.net/)
- [Porthole](https://github.com/Gre4ka43/Place-Together)

Create or join the same virtual network and make sure all participants can reach the host computer.

### 4. Configure Windows Firewall

Windows Firewall may block incoming connections to the server.

If the connection fails, check your firewall settings and allow the server application and its required network traffic through Windows Defender Firewall.

**Security note:** Disabling Windows Firewall entirely is not recommended. Prefer allowing only the required application or port, and only on trusted networks.

### 5. Start the Server

Run the provided `.bat` file on the host computer to start the server.

Keep the server running while other participants are connected.

### 6. Connect Through the Plugin

Open Roblox Studio and launch the Place Together plugin.

Enter the host's virtual LAN IP address and any other connection details requested by the plugin.

Make sure everyone is connected to the same virtual network and uses compatible versions of the plugin and server.

## Troubleshooting

- **Cannot connect:** Verify that everyone is on the same virtual network and that the host's virtual IP address is correct.
- **Connection blocked:** Check Windows Firewall rules and whether the server is listening on the required port.
- **Server unavailable:** Make sure the host has started the server and kept the console open.
- **Still not working:** Check the server console for errors and review the network tool's connection status.
