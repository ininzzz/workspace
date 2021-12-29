#include<pthread.h>
#include<stdio.h>
#include<unistd.h>
#include<semaphore.h>


sem_t s;
void* func1(){
    sem_wait(&s);
    printf("what the fuck\n");
    sleep(2);
    sem_post(&s);
}

void* func2(){
    sem_wait(&s);
    printf("hello world\n");
    sem_post(&s);
}

int main(){
    pthread_t p1,p2;
    sem_init(&s,0,0);
    int ret;
    ret=pthread_create(&p1,NULL,func1,NULL);
    ret=pthread_create(&p2,NULL,func2,NULL);
    pthread_join(p2,NULL);
    return 0;
}