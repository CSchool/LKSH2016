#include<iostream>
using namespace std;

int main()
{
    int x,n,s,z;
    cin >>n>>s;
    x=(1+n)*(n/2);
    x=x-s;
    if(x>2){
    if(x%2==0){z=x/2;
    cout <<"yes"<<endl;
    cout <<z-1<<" "<<z+1;}
    if(x%2==1){z=(x-1)/2;
     cout <<"yes"<<endl;
    cout <<z<<" "<<z+1;}}

    else {cout <<"no";};

    return 0;
}
