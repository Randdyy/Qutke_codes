import multiprocessing,time,threading

def thread_run():
    print(threading.get_ident()) #线程号

def run(name):
    print("hello",name)
    t = threading.Thread(target=thread_run,)
    t.start()
    time.sleep(2)

if __name__ == '__main__':

    for i in range(10):
        p = multiprocessing.Process(target=run,args=('Bob %s'%i,))
        p.start()