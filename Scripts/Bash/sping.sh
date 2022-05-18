#!/bin/bash
rm /tmp/xping.sh

echo "#!/bin/bash" >> /tmp/xping.sh
chmod +x /tmp/xping.sh
for hosts in {1..254};
do
  echo "ping -w 1 -c 1 192.168.2.$hosts " '| grep "64 bytes" & ' >> /tmp/xping.sh
done

echo "wait" >> /tmp/xping.sh
bash /tmp/xping.sh

 