#! /bin/bash

html=`curl -s http://wjw.wuhan.gov.cn/front/web/list2nd/no/710`
latestContent=`echo "$html" |  grep showDetail | awk -F '[\"\"]' '{print $4}'`

oldmsg='''武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
关于武汉市新型冠状病毒感染的肺炎新增病例有关情况
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
关于我市新型冠状病毒感染的肺炎防控工作有关情况
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
新型冠状病毒感染的肺炎疫情知识问答
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
专家解读不明原因的病毒性肺炎最新通报
武汉市卫生健康委关于不明原因的病毒性肺炎情况通报
关于2019年度武汉市优质服务基层行活动市级复核结果的公示
武汉市卫生健康委员会关于不明原因的病毒性肺炎情况通报
'''
msg=`diff -B  <(echo "$latestContent")  <(echo "$oldmsg")`

if test -z "$msg"
then
  : 
else  
  msg=`echo "$latestContent" | head -n1`
  echo $msg
  time=`echo "$html" |  grep "time" |  awk -F "[\>\<]" '{print $3}' | head -n1`
  echo $time
  link=`echo "$html" |  grep "showDetail" | awk -F "[\"\"]" '{print $2}' | head -n1`
  echo $link
  /usr/local/bin/terminal-notifier -group 'zxReminder' -title 'News' -subtitle "$msg"  -message "$time"  -open "$link"
fi

