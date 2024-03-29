#--!/bin/sh

#--if user calls script incorrectly, let them know how to call it:
if [ $# -ne 1 ];
then
  echo "[:] Usage: $0 URLs.txt";
  exit -1
fi
#--ask user to confirm start of script, define variable $resp:
echo ""
read -p "[:] wayback machine bulk URL archive saver, shall we begin? (y/n) " resp
echo ""
#--if user enters 'y', begin loop:
if [ "$resp" = "y" ]; then
  #--define variable $lines as each line in a file $1, and start for loop:
  lines=$(cat $1)
  for line in $lines;
  do
    #--tell user which URL we are uploading and upload to the wayback machine, and save output stout and sterr to a log file:
    echo "[:] URL: "$line
    waybackpy --url $line --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101 Firefox/96.0" --save >> ./wbpbu.log.txt 2>&1 &
    #--the wayback API limits 15 urls/min upload, wait 15 seconds to accomodate this (experiment with timing, wayback server is fussy.)
    for i in {1..5};
    do
      echo -en "\r\e[K[:] uploading ."
      sleep 0.5
      echo -en "\r\e[K[:] uploading .."
      sleep 0.5
      echo -en "\r\e[K[:] uploading ..."
      sleep 0.5
      echo -en "\r\e[K[:] uploading ."
      sleep 0.5
      echo -en "\r\e[K[:] uploading .."
      sleep 0.5
      echo -en "\r\e[K[:] uploading ..."
      sleep 0.5
    done
    echo ""
    tail -n 2 ./wbpbu.log.txt
    echo ""
  done
  echo "[:] completed."
else
  echo "[:] exiting..."
  exit -1
fi
