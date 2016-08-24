// perviy.cpp: определяет точку входа для консольного приложения.
//

#include"iostream"

using namespace std;

int main()
{
	int n,s,kek=0;
	cin>>n>>s;

	for(int i=1;i<=n;i++){
		kek+=i;
	}
	if (s==kek){
		cout<<"no";
		return 0;
	}
	for(int i=1;i<=n;i++){
		for(int j=1;j<=n;j++){
			if(i+j+s==kek){
				cout<<"yes"<<endl;;
				cout<<i<<j;
				return 0;
			}
		}
	}
	return 0;
}

