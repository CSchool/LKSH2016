// zadacha.cpp: определяет точку входа для консольного приложения.
//

#include "iostream"
#include "vector"

using namespace std;

int main()
{
	//freopen("input.txt","r",stdin);
	//freopen("output.txt","w",stdout);
	long long n,s,sum=0;
	cin>>n>>s;
	vector<int> table(n);
	for(int i=0;i<=n;i++)
		sum+=i;
	for (int i=1;i<=n;i++){
		for(int j=1;j<=n;j++){
			if(i!=j && i+j+s==sum && sum!=s){
				cout<<"yes"<<endl;
				cout<<i<<" "<<j;
				return 0;
			}
		}		
	}
	cout<<"no";
	return 0;
}

