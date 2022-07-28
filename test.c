#include <stdio.h>
#include "example.h"

int main(void)
{
    void *p = example_init();
    printf("%d\n", example_count(p, 1));
    printf("%d\n", example_count(p, 2));
    return 0;
}
