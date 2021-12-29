#include<iostream>
#include<vector>
#include<random>
#include<time.h>
#include<unistd.h>

#include"threadpool.h"

int sum=0;

struct dd{
    int id,port;
    void process(){
        for(int i=0;i<1000000;i++){
            sum+=(id%2?1:-1);
        }
        std::cout<<id<<std::endl;
    }
};

int main(){
    srand(time(NULL));
    threadpool<dd> tp;
    std::vector<dd> vec;
    for(int i=0;i<20;i++){
        vec.push_back(dd{i,rand()%65536});
    }
    for(auto &x:vec){
        tp.append(&x);
    }
    sleep(5);
    std::cout<<sum<<std::endl;
}