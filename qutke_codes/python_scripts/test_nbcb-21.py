
import json
import threading
import time
import requests
import random
url = 
def request_nbcb(url,thread_no):
    header = {
    'Host': 'fxmm-fof.nbcb.com.cn',
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36}'
    }
    cookie = {'fp_ver':'3.4.6',
    'BSFIT_SMART':'0587F3A354A68FBF38BB04994FF6F54C',
    'BSFIT_DEVICEID':'a8ac4c6f33440b1d094beb178866fd1159c9b16549d8734519b6c4e944382147',
    'BSFIT_EXPIRATION':'1598359649523',
    'BSFIT_TRACEID':'5f1a9855f89829f14a6aee8f',
    'connect.sid':'s%3A8rDfJoSr8q75yXsMBIeHaJVN51VAxWqC.gWrlx1dHbPXVFBKPF092p0FdkGB9UaorIdgXXgLvFtc',
    'BSFIT_OkLJUJ':'ABAINJEXHVS7K71J'
}
    while 1:
        time.sleep(random.randint(0,5))
        result = requests.get(url,headers=header,cookies=cookie ,params={'customerId':'0000070401','userNo':'517','sessionId':'BFBJGZFGHMDABSGNINAAIWFGHFDPHABNIGDZIOCU'})
        # print(result.json)
        result.encoding='utf-8'
        print('thread_no:'+str(thread_no),'  result:'+result.text)
    # print(result.json)


for i in range(10):
    t = threading.Thread(target=request_nbcb,args=[url,i])
    t.start()
