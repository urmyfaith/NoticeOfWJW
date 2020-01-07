#! /bin/bash

curl -s http://wjw.wuhan.gov.cn/front/web/list2nd/no/710 >temp.html

cat temp.html |  grep "showDetail" | awk -F "[\"\"]" '{print $4}' > latest.txt

msg=`diff -B  <(cat latest.txt)  <(cat lines.txt) | tail -n1`

if test -z "$msg"
then
  : 
else  
  msg=`echo $msg | awk '{print $2}'`
  #echo $msg
  time=`cat temp.html |  grep "time" |  awk -F "[\>\<]" '{print $3}' | head -n1`
  #echo $time
  link=`cat temp.html |  grep "showDetail" | awk -F "[\"\"]" '{print $2}' | head -n1`
  curl -s "$link" >msg.html
  terminal-notifier -group 'zxReminder' -title 'News' -subtitle "$msg"  -message "$time"  -open "$link"
fi
