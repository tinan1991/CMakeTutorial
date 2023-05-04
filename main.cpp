#include <math.h>
#include <iostream>
#include "TutorialConfig.h"

int main(int argc, char *argv[]) {
    std::cout<<"Version : " << VERSION_FULL << std::endl;
    if(argc < 2) {
        std::cout<< "Usage:" << argv[0] << "numbers" <<std::endl;        
        return 1;
    }
    double in = atof(argv[1]);
    double out = sqrt(in);
    std::cout<<"The square root of " << in << " is " << out << std::endl;
    return 0;
}
