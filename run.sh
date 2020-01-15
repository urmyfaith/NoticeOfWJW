#! /bin/bash

html=`curl -s http://wjw.wuhan.gov.cn/front/web/list2nd/no/710`
latestContent=`echo "$html" |  grep showDetail | awk -F '[\"\"]' '{print $4}'`

oldmsg='''新型冠状病毒感染的肺炎疫情知识问答
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
武汉市卫生健康委员会关于新型冠状病毒感染的肺炎情况通报
专家解读不明原因的病毒性肺炎最新通报
武汉市卫生健康委关于不明原因的病毒性肺炎情况通报
关于2019年度武汉市优质服务基层行活动市级复核结果的公示
武汉市卫生健康委员会关于不明原因的病毒性肺炎情况通报
武汉市卫健委关于不明原因的病毒性肺炎情况通报
武汉市卫健委关于当前我市肺炎疫情的情况通报
武汉市卫生健康委随机抽查事项指引
武汉市卫生健康委随机抽查事项清单（2019版）
2019年市卫生健康委重大行政决策事项目录表
关于2019年度湖北省卫生技术（武汉）高级职务评审委员会卫生技术高级职务评审结果的公示
市卫生健康委关于2019年全市医疗机构依法执业综合检查情况的通报
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

