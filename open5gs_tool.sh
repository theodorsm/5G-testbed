#!/bin/sh
NFLIST="amf ausf bsf hss mme nrf nssf pcf pcrf scp sgwc sgwu smf udm udr upf"

dostart() {
	for nf in $NFLIST; do
		echo systemctl start open5gs-${nf}d
	done
}

dostatus() {
	for nf in $NFLIST; do
		echo systemctl status open5gs-${nf}d
	done
}

dostop() {
	for nf in $NFLIST; do
		echo systemctl stop open5gs-${nf}d
	done
}

dorestart() {
	for nf in $NFLIST; do
		echo systemctl restart open5gs-${nf}d
	done
}

dodisable() {
	for nf in $NFLIST; do
		echo systemctl disable open5gs-${nf}d
	done
}

doenable() {
	for nf in $NFLIST; do
		echo systemctl enable open5gs-${nf}d
	done
}

dosetup() {
	for nf in $NFLIST; do
		file="/lib/systemd/system/open5gs-${nf}d.service"
		rm "$file"
		touch "$file"
		echo "[Unit]" >> $file
		echo "Description=Open5GS ${nf}" >> $file
		echo "[Service]" >> $file
		echo "WorkingDirectory=/root/open5gs/install/bin" >> $file
		echo "ExecStart=/root/open5gs/install/bin/open5gs-${nf}d -c /etc/open5gs/${nf}.yaml" >> $file
		echo "Restart=always" >> $file
		echo "RestartSec=2" >> $file
		echo "[Install]" >> $file
		echo "WantedBy=multi-user.target" >> $file
	done
}




case $1 in
	start) dostart ;;
	status) dostatus;;
	stop) dostop ;;
	restart) dorestart ;;
	disable) dodisable ;;
	enable) doenable ;;
	setup) dosetup;;
esac
