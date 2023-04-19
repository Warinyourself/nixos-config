{ lib, pkgs, ... }:
let
  vpnDir = "/home/warinyourself/Documents/Sync/vpn";
in
{
  home.file."Documents/Sync/vpn/work.conf".text = ''
    client
    pull
    auth SHA256
    cipher AES-256-CBC
    dev tun
    tun-mtu 1400
    mode p2p

    remote openvpn.o3.ru 1194 udp
    #remote openvpn.o3.ru 443 tcp-client
    remote-random-hostname
    resolv-retry 60
    connect-timeout 5
    nobind
    push-peer-info
    auth-user-pass ${vpnDir}/pass
    remote-cert-tls server

    static-challenge  "Enter OTP Authenticator Code"  1

    script-security 2
    up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
    up-restart
    down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
    down-pre
    ca ${vpnDir}/ca
  '';
}
