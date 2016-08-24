#include<iostream>
using namespace std;

int main()
{
    long long int x,n,s,z;
    cin >>n>>s;
    x=(1+n)*(n/2);
    x=x-s;
    if(x>2){
    if(x%2==0){z=x/2;
    cout <<"yes"<<endl;
    cout <<z-1<<" "<<z+1;}else {cout <<"no";};}
    else {cout <<"no";};

    return 0;
}
