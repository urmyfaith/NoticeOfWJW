#! /bin/bash

html=`curl -s http://wjw.wuhan.gov.cn/front/web/list2nd/no/710`
latestContent=`echo "$html" |  grep showDetail | awk -F '[\"\"]' '{print $4}'`

oldmsg='''武汉市卫生健康委员会关于不明原因的病毒性肺炎情况通报
武汉市卫健委关于不明原因的病毒性肺炎情况通报
武汉市卫健委关于当前我市肺炎疫情的情况通报
武汉市卫生健康委随机抽查事项指引
武汉市卫生健康委随机抽查事项清单（2019版）
2019年市卫生健康委重大行政决策事项目录表
关于2019年度湖北省卫生技术（武汉）高级职务评审委员会卫生技术高级职务评审结果的公示
市卫生健康委关于2019年全市医疗机构依法执业综合检查情况的通报
2019年四季度武汉市市政管网末梢水检测结果
医疗机构设置公示（武汉洪山巢之安健康体检中心）
关于开展12月份领导干部下基层大接访行动的通告
市卫生健康委关于2019年十三五中医重点专科（专病）评审结果公示
武汉市卫生健康委员会政务服务“好差评”工作制度(试行)
武汉市卫生健康委专项招聘高层次及急需紧缺人才公告
武汉市产前筛查和产前诊断机构名单
'''
msg=`diff -B  <(echo "$latestContent")  <(echo "$oldmsg") | tail -n1`

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

