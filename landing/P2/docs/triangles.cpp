// Test.cpp : Defines the entry point for the console application.
//

//подключаем библиотеку для работы с входным и выходным потоками, то есть для чтения и записи данных.
#include <iostream>
//подключаем библиотеку с математическими формулами
#include <cmath>

using namespace std;

// задаем максимально возможный размер массива, который потом нельзя будет изменить
const int size = 50;

int main()
{
    int n = 0;   // объявляем переменную под количество точек для чтения
    double p[size][2];   /* массив, хранящий координаты точек 
	вид массива: 
	
				j: 0 	1
		i:	  0	 | x1 | y1 |
			  1	 | x2 | y2 |
				 ...
			  49 | x50| y50| 
		  */

    cin >> n  // считываем заданное количество точек

    for (int i = 0; i < n; ++i)   // цикл от 0 до n для заполнения массива координатами точек
        cin >> p[i][0] >> p[i][1];  // заполняем массив координатами, в первый столбик значение x, во второй столбик значение y

    double min = 99999999999999;   // объявляем переменную для хранения минимального периметра, выставляем большое число, чтобы сравнивать с ним, так как явно все наши переметры будут меньше него
    int ri = 0, rj = 0, rk = 0;		// переменные для хранения индексов точек, в которых треугольник будет иметь наименьший периметр

    for (int i = 0; i < n; ++i)      // рассматриваем всевозможные значения первой точки
        for (int j = i + 1; j < n; ++j)  // так же для второй точки, берем индекс предыдущего+1 для исключения повторяющися вариантов
            for (int k = j + 1; k < n; ++k)  // аналогично для третьей точки
            {
                // i and j
                double p1 = sqrt(pow(p[i][0] - p[j][0], 2) + pow(p[i][1] - p[j][1], 2));   // находим длину стороны от точки с индексом i до точки с индексом j
                // i and k
                double p2 = sqrt(pow(p[i][0] - p[k][0], 2) + pow(p[i][1] - p[k][1], 2));	// находим длину стороны от точки с индексом i до точки с индексом k
                // j and k
                double p3 = sqrt(pow(p[k][0] - p[j][0], 2) + pow(p[k][1] - p[j][1], 2));	// находим длину стороны от точки с индексом k до точки с индексом j

                if (p1 + p2 + p3 < min) 		// проверяем получившийся периметр на минимум, то есть на то, является ли он наименьшим. Для этого сравниваем его с переменной min
                {
                    min = p1 + p2 + p3;		 // раз получившийся периметр оказался меньше предыдущего сохраненного там, то нам нужно обновить минимальное значение
                    ri = i;		// сохраняем индекс точки I
                    rj = j;		// сохраняем индекс точки J
                    rk = k;		// сохраняем индекс точки K
                }

            }

    cout << ri + 1 << " " << rj + 1 << " " << rk + 1 << endl;	// выводи найденный результат. Стоит учесть, что индексация массивов начинается с 0, то есть первый индекс - 0, а отсчет номеров в математике начинается с 1, значит нужно увеличить каждый найденный индекс на 1.

	return 0;	//возвращаем 0, для операционной системы это будет означать, что все хорошо и программа завершилась без каких-либо ошибок
}

