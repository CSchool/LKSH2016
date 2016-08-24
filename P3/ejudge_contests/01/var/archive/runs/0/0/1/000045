#include<iostream>
using namespace std;

int a[11];
int main()
{
    long long int x,n,s,z;
    cin >>n>>s;
    a[1]=1;
    a[2]=3;
    for(int i=3;i<=11;i++)
    {
        a[i]=a[i-1]+i;
    }
    x=a[n]-s;
    if(x<3){cout <<"no";}
    else{if(x%2==0){z=x/2;
    if(z<n){cout <<"yes"<<endl;cout <<z-1<<" "<<z+1;}
    else{cout <<"no";}}
    else{z=(x-1)/2;
    if(z<n){cout <<"yes"<<endl;cout <<z<<" "<<z+1;}
    else{cout <<"no";};};}


    return 0;
}
