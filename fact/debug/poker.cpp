#include <iostream>
using namespace std;
int Two=0,ppp=0,ThreeofaKind=0,FullHouse=0,c=0,a=0,k=0,Straight=0;
int main()
{
  
  int mas[5];
for (int i=0; i<5; i++)
{
  cin>>mas[i];
}

for(int i=0; i<5; i++)
{
      for(int j=0; j<5; j++)
     {
            if(mas[j]>mas[i])
            {
                int a = mas[i];
                mas[i] = mas[j];
                mas[j] = a;
            }
     }
}

for(int i=0; i<5; i++)
{
    if (mas[i+1]-mas[i]==1)
    {
      Straight=Straight+1;
    }
    if (mas[i]==mas[i+1]) 
    {
    k=k+1;    
    }
}
  if (mas[0]==mas[1] && mas[1]==mas[2] && mas[3]==mas[4] || mas[0]==mas[1] && mas[2]==mas[3] && mas[3]==mas[4])
    {
    FullHouse=FullHouse+1;
    }
    
    if (mas[0]==mas[1] && mas[1]==mas[2]  || mas[1]==mas[2] && mas[2]==mas[3] || mas[2]==mas[3] && mas[3]==mas[4])
    {
      ThreeofaKind=ThreeofaKind+1;
    }
    if (mas[0]==mas[1] && mas[1]==mas[2] && mas[2]==mas[3] || mas[1]==mas[2] && mas[2]==mas[3] && mas[3]==mas[4])
    {
      ppp=ppp+1;
    }
    if (mas[0]==mas[1] && mas[2]==mas[3] || mas[1]==mas[2] && mas[3]==mas[4] || mas[0]==mas[1] && mas[3]==mas[4])
    {
      Two=Two+1;
    } 
    


if (k==4) cout <<"Impossible";
if (FullHouse==1) cout <<"Full House"; else 
if (Straight==4) cout << "Straight"; else 
if (ppp==1) cout << "Four of a Kind"; else
if (ThreeofaKind==1) cout << "Three of a Kind"; else
if (Two==1) cout << "Two Pairs"; else
if (k==1) cout << "One Pair"; else cout<<"Nothing";

}
