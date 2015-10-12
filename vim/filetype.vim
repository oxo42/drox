au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif 
au BufRead,BufNewFile /opt/splunk/*/*.conf,/opt/splunk/*/*.meta setfiletype dosini 
au BufRead,BufNewFile /opt/splunkforwarder/*/*.conf,/opt/splunkforwarder/*/*.meta setfiletype dosini 
