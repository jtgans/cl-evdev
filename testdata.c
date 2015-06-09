#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
  struct input_event {
    struct timeval time;
    unsigned short type;
    unsigned short code;
    unsigned int value;
  } event;

  int fd = open("testdata.dat", O_RDONLY);

  if (fd < 0) {
    return 1;
  }

  int bytesRead = 0;
  while ((bytesRead = read(fd, &event, sizeof(struct input_event))) > 0) {
    printf("time: %ld.%ld type: %d, code: %d, value: %d\n",
           event.time.tv_sec, event.time.tv_usec,
           event.type, event.code, event.value);
  }

  close(fd);
  return 0;
}
