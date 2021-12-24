#include<unistd.h>
#include<sys/stat.h>
#include<sys/socket.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<assert.h>
#include<errno.h>
#include<string.h>
#include<stdlib.h>
#include<stdio.h>
#include<fcntl.h>
#include<sys/ioctl.h>
#include<poll.h>

#define SIZE 64

void run2(const char *ip,int port){
    struct sockaddr_in seversock;
    bzero(&seversock,sizeof(seversock));
    seversock.sin_family=AF_INET;
    seversock.sin_addr.s_addr=inet_addr(ip);
    seversock.sin_port=htons(port);

    int clientsockfd=socket(AF_INET,SOCK_STREAM,0);
    if(connect(clientsockfd,(struct sockaddr *)&seversock,sizeof(seversock))<0){
        printf("connection failed\n");
        close(clientsockfd);
        return;
    }

    struct pollfd pfd[2];
    pfd[0].fd=STDIN_FILENO;pfd[0].events=POLLIN;pfd[0].revents=0;
    pfd[1].fd=clientsockfd;pfd[1].events=POLLOUT|POLLIN;pfd[1].revents=0;
    while(1){
        int ret=poll(pfd,2,-1);
        if(ret<0){
            printf("poll error\n");
            close(clientsockfd);
            return;
        }
        if(pfd[1].revents&POLLIN){
            char buf[SIZE];
            memset(buf,0,sizeof(buf));
            read(pfd[1].fd,buf,SIZE-1);
            printf("%s",buf);
        }
        if(pfd[0].revents==POLLIN&&(pfd[1].revents&POLLOUT)){
            char buf[SIZE];
            memset(buf,0,sizeof(buf));
            read(pfd[0].fd,buf,SIZE-1);
            write(pfd[1].fd,buf,strlen(buf));
        }
    }
    close(clientsockfd);
    return;
}

int main(int argc,char *argv[]){
    run2(argv[1],atoi(argv[2]));
    return 0;
}