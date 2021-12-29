#include<pthread.h>
#include<stdio.h>
#include"../Web/locker.h"

int sum=0;
locker lock;

void* func1(void* data){
    for(int i=0;i<100000;i++){
        lock.lock();
        sum++;
        lock.unlock();
    }
    return NULL;
}

void* func2(void* data){
    for(int i=0;i<100000;i++){
        lock.lock();
        sum--;
        lock.unlock();
    }
    return NULL;
}

int main(){
    pthread_t p1,p2;
    pthread_create(&p1,NULL,func1,NULL);
    pthread_create(&p2,NULL,func2,NULL);
    pthread_join(p1,NULL);
    pthread_join(p2,NULL);
    printf("%d\n",sum);
    return 0;
}