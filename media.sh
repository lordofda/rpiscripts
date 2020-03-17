#!/bin/bash
tree -L 3 -sh -C /home/osmc/Videos | ansi2html.sh > /home/osmc/txt/vid.html
tree -L 3 -sh -C /home/osmc/Movies | ansi2html.sh > /home/osmc/txt/mov.html
tree -L 3 -sh -C /home/osmc/Porn | ansi2html.sh > /home/osmc/txt/prn.html
tree -L 3 -sh -C /media/KINGSTON | ansi2html.sh > /home/osmc/txt/usb.html
for i in /home/osmc/txt/*; do
	sed -i '/[0-999]K/d' $i
	sed -i '/.nfo/d' $i
	sed -i '/.txt/d' $i
	sed -i '/.part/d' $i
	sed -i '/.srt/d' $i
	sed -i '/.sh/d' $i
	sed -i '/.sub/d' $i
	sed -i '/.idx/d' $i
	sed -i '/directories/d' $i
	sed -i '/^\s*$/d' $i
	sed -i -e 's/^[ \t]*//' $i
done
tremc -- -l > /home/media/txt/torr.txt
rsync -r /home/osmc/txt/* pi@192.168.1.2:/var/www/media/
