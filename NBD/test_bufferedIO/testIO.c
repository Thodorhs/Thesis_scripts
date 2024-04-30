#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/time.h>

#define SEC_TO_NS(sec) ((sec)*1000000000)
#define BUF_LEN 5000000
#define EXPORT "/mnt/fmap/BufferedIO/bufferedIO.txt"



int main() {
    char buffer[BUF_LEN];
    int fd;
    fd = open(EXPORT, O_RDWR);
    ssize_t bytes;
    struct timeval start, end;
    long seconds, micro;
    double elapsed;

    if(fd < 0) {
        printf("ERROR: File desc NULL.\n");
        return 1;
    }
    memset(buffer, '1', BUF_LEN);

    printf("Attempting write operations.\n");

    gettimeofday(&start, NULL);
    bytes = write(fd, buffer, BUF_LEN);
    gettimeofday(&end, NULL);

    seconds = end.tv_sec - start.tv_sec;
    micro = end.tv_usec - start.tv_usec;
    elapsed = seconds + micro / 1000000.0;
    if(bytes < 0) {
        printf("ERROR: failed to WRITE data.\n");
        close(fd);
        return 1;
    }
    printf("%ln WRITE operations completed in : %.6f secs.\n", &bytes, elapsed);

    printf("Attempting read operations.\n");

    gettimeofday(&start, NULL);
    bytes = read(fd, buffer, BUF_LEN);
    gettimeofday(&end, NULL);

    seconds = end.tv_sec - start.tv_sec;
    micro = end.tv_usec - start.tv_usec;
    elapsed = seconds + micro / 1000000.0;

    if(bytes < 0) {
        printf("ERROR: failed to READ data.\n");
        close(fd);
        return 1;
    }
    printf("%ln READ operations completed in : %.6f secs.\n", &bytes, elapsed);
    //printf("Buffer: %s\n", buffer);

    close(fd);
    return 0;
}
