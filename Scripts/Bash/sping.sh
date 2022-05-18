#!/bin/bash
rm /tmp/xping.sh
if [ "$1" == ""]
then
    echo "SuperPing - UltraFast"
    echo "How to use: $0 REDE"
    echo "Usage: ./sping 10.20.0" 
else
  echo "#!/bin/bash" >> /tmp/xping.sh
  chmod +x /tmp/xping.sh
for hosts in {1..254};
 do
   echo "ping -w 1 -c 1 $1.$hosts " '| grep "64 bytes" & ' >> /tmp/xping.sh
 done

 echo "wait" >> /tmp/xping.sh
 
 bash /tmp/xping.shd
fi

 