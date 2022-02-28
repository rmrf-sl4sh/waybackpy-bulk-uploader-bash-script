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
			#--tell user which URL we are uploading and upload to the wayback machine:
			echo "[:] Uploading $line now..."
			waybackpy --url $line --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101 Firefox/96.0" --save
			#--the wayback API limits 15 urls/min upload, wait 5 seconds to accomodate this
			echo "[:] waiting 5 seconds..."
			sleep 5
		done
	echo "[:] completed."
else
	echo "[:] exiting..."
	exit -1
fi