#! /bin/bash

curl -s http://wjw.wuhan.gov.cn/front/web/list2nd/no/710 >temp.html

cat temp.html |  grep "showDetail" | awk -F "[\"\"]" '{print $4}' > latest.txt

diff -B  <(cat latest.txt)  <(cat lines.txt)
msg=`diff -B  <(cat latest.txt)  <(cat lines.txt) | tail -n1`

if test -z "$msg"
then
  : 
else  
  msg=`echo $msg | awk '{print $2}'`
  #echo $msg
  terminal-notifier -group 'zxReminder' -title 'News' -message $msg
fi
