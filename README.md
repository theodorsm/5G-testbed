5G testbed for security reseach. Vagrant setup with two VMs, one for 5G core network and another for RAN/UE. A [modified version of Open5gs](https://github.com/theodorsm/open5gs/tree/testcases) is used together with an [interceptor](https://github.com/theodorsm/5G-interceptor) to run testcases with modified NAS messages.

## Setup

```bash
vagrant up
```

*It can take a while to create the VMs as open5gs needs to be compiled*.

## Running testcases

### CORE

Network functions should already be running.

Start packet capture on CORE:

```bash
vagrant ssh open5gs
sudo su

apt install tshark
tshark -i lo -w /tmp/testrun.pcap
```

Status of network functions can be checked with:

```bash
/root/open5gs_tools.sh status | bash
```

Logs can be found in `/var/log/open5gs`, and configuration files in `/etc/open5gs/`.

Run testcase server:

```bash
cd /root/5G-interceptor
./run-testcases
```

### RAN/UE

```bash
vagrant ssh open5gs
sudo su
cd /root/UERANSIM

# run in seperate terminals:
./build/nr-gnb -c config/open5gs-gnb.yaml
./build/nr-ue -c config/open5gs-ue.yaml
```
