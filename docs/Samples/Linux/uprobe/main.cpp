#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

struct WORK
{
    int a; int b;
};

int FastPathLogic(struct WORK *work)
{
    sleep(1);
    return 0;
}

int SlowPathLogic(struct WORK *work)
{
    sleep(2);
    return 0;
}

int FastPath(struct WORK *myWork)
{
    //
    // Execute fast path logic over packet
    //
    return FastPathLogic(myWork);
}
  
int SlowPath(struct WORK *myWork)
{ 
    //
    // Execute slow path logic over packet
    //
    return SlowPathLogic(myWork);
} 

 
int main() 
{   
    for(;;)
    {
        WORK *myWork = new WORK();
        
        if(0==rand()%1000)
            SlowPath(myWork);
        else
            FastPath(myWork);
    }
    return 0; 
} 