* 엑셀 파일 다루기 1: 데이터 다루기

그러면 본격적으로 엑셀로 하던 작업을 pandas를 사용하여 수행해봅시다.

(여기서 사용한 일부 데이터는, 통계청 산하 통계교육원의 [[https://sti.kostat.go.kr/coresti/site/board/StudentBoardViewList.do][이러닝 실습 자료]]를 사용하였습니다.)

#+BEGIN_SRC ipython :session :exports none
%matplotlib inline
from tabulate import tabulate

def tab(df):
    print(tabulate(df, headers='keys', tablefmt='orgtbl'))
#+END_SRC

#+RESULTS:

엑셀로 자주 하던 작업들을 떠올려보면, 대략 아래와 같은 것들이 있습니다. 하나씩 살펴보도록 합시다.

 - Sorting
 - 컬럼별로 unique value 보기
 - 컬럼별 value frequency 보기
 - Pivot table로 보기
 - Vlookup (join)
 - 그래프 그리기
 - 새 컬럼에 recoding하기
 - 특정 컬럼에 특정 값을 가지는 row들만 보기


** 함수 목록

이번 실습에서 사용할 함수/메소드들을 미리 살펴보겠습니다.

Pandas의 일반 함수들 ([[https://pandas.pydata.org/pandas-docs/stable/api.html#input-output][전체 목록]])

 - read_excel(path, sheet_name=0) :: 엑셀 파일을 읽어들인다.
 - pivot_table(data_frame) :: 피벗 테이블을 만든다.
 - merge(data_frame_1, data_frame_2) :: 두 데이터 프레임을 병합한다.

DataFrame의 메소드들 ([[https://pandas.pydata.org/pandas-docs/stable/api.html#dataframe][전체 목록]])

 - DataFrame(series_list, index=index_list) :: DataFrame 생성 함수.
 - sort_values(column_name, ascending=True) :: 특정 컬럼(또는 컬럼들)을 기준으로 정렬한다.
 - describe() :: 데이터의 요약 정보를 가져온다.
 - apply(func) :: DataFrame의 모든 셀에 함수를 적용하여 새 DataFrame을 반환한다.
 - corr() :: 변수들간의 상관관계 테이블을 구한다.
 - to_excel(path) :: 엑셀 파일로 저장한다.

Series의 메소드들 ([[https://pandas.pydata.org/pandas-docs/stable/api.html#series][전체 목록]])

 - describe() :: 데이터의 요약 정보를 가져온다.
 - value_counts(normalize=False) :: 값의 빈도 분포를 가져온다.


** 엑셀 파일 읽어들이기

우선, 데이터로 사용할 엑셀 파일을 jupyter notebook으로 읽어들입니다.

#+BEGIN_SRC ipython :session :exports code :results raw
import pandas as pd

df = pd.read_excel('https://github.com/toracle/python-basic-lecture/raw/master/assets/%EC%97%91%EC%85%80%EA%B3%BC%EC%A0%95%EC%8B%A4%EC%8A%B5%EC%83%9D.xlsx', sheet_name='Sheet1')
df
#+END_SRC

#+RESULTS:
# Out[2]:
#+BEGIN_EXAMPLE
  번호  나이  성별  신장(cm)  몸무게(kg)  즐기는 음식
  0    1  30   1     183       82       1
  1    2  28   2     160       62       3
  2    3  27   1     178       77       2
  3    4  23   1     172       70       2
  4    5  25   1     168       72       3
  5    6  27   1     179       77       1
  6    7  26   1     169       71       1
  7    8  29   1     171       75       3
  8    9  34   2     158       60       2
  9   10  31   1     183       77       3
  10  11  26   2     162       59       1
  11  12  26   1     173       70       2
  12  13  35   1     173       68       3
  13  14  24   1     176       66       3
  14  15  29   2     170       70       2
  15  16  33   1     177       72       2
  16  17  38   2     159       55       1
  17  18  26   1     166       69       3
  18  19  26   1     169       66       2
  19  20  28   2     159       60       2
#+END_EXAMPLE

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df)
#+END_SRC

#+RESULTS:
|    | 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|----+------+------+------+----------+------------+-------------|
|  0 |    1 |   30 |    1 |      183 |         82 |           1 |
|  1 |    2 |   28 |    2 |      160 |         62 |           3 |
|  2 |    3 |   27 |    1 |      178 |         77 |           2 |
|  3 |    4 |   23 |    1 |      172 |         70 |           2 |
|  4 |    5 |   25 |    1 |      168 |         72 |           3 |
|  5 |    6 |   27 |    1 |      179 |         77 |           1 |
|  6 |    7 |   26 |    1 |      169 |         71 |           1 |
|  7 |    8 |   29 |    1 |      171 |         75 |           3 |
|  8 |    9 |   34 |    2 |      158 |         60 |           2 |
|  9 |   10 |   31 |    1 |      183 |         77 |           3 |
| 10 |   11 |   26 |    2 |      162 |         59 |           1 |
| 11 |   12 |   26 |    1 |      173 |         70 |           2 |
| 12 |   13 |   35 |    1 |      173 |         68 |           3 |
| 13 |   14 |   24 |    1 |      176 |         66 |           3 |
| 14 |   15 |   29 |    2 |      170 |         70 |           2 |
| 15 |   16 |   33 |    1 |      177 |         72 |           2 |
| 16 |   17 |   38 |    2 |      159 |         55 |           1 |
| 17 |   18 |   26 |    1 |      166 |         69 |           3 |
| 18 |   19 |   26 |    1 |      169 |         66 |           2 |
| 19 |   20 |   28 |    2 |      159 |         60 |           2 |


** 특정 컬럼으로 정렬하기

키가 큰 순서대로 정렬을 해볼까요?

#+BEGIN_SRC ipython :session :results raw :exports code
df.sort_values('신장(cm)')
#+END_SRC

#+BEGIN_SRC ipython :session :results raw output :exports result
tab(df.sort_values('신장(cm)'))
#+END_SRC

#+RESULTS:
|    | 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|----+------+------+------+----------+------------+-------------|
|  8 |    9 |   34 |    2 |      158 |         60 |           2 |
| 16 |   17 |   38 |    2 |      159 |         55 |           1 |
| 19 |   20 |   28 |    2 |      159 |         60 |           2 |
|  1 |    2 |   28 |    2 |      160 |         62 |           3 |
| 10 |   11 |   26 |    2 |      162 |         59 |           1 |
| 17 |   18 |   26 |    1 |      166 |         69 |           3 |
|  4 |    5 |   25 |    1 |      168 |         72 |           3 |
|  6 |    7 |   26 |    1 |      169 |         71 |           1 |
| 18 |   19 |   26 |    1 |      169 |         66 |           2 |
| 14 |   15 |   29 |    2 |      170 |         70 |           2 |
|  7 |    8 |   29 |    1 |      171 |         75 |           3 |
|  3 |    4 |   23 |    1 |      172 |         70 |           2 |
| 11 |   12 |   26 |    1 |      173 |         70 |           2 |
| 12 |   13 |   35 |    1 |      173 |         68 |           3 |
| 13 |   14 |   24 |    1 |      176 |         66 |           3 |
| 15 |   16 |   33 |    1 |      177 |         72 |           2 |
|  2 |    3 |   27 |    1 |      178 |         77 |           2 |
|  5 |    6 |   27 |    1 |      179 |         77 |           1 |
|  0 |    1 |   30 |    1 |      183 |         82 |           1 |
|  9 |   10 |   31 |    1 |      183 |         77 |           3 |

이런, 키가 작은 순으로 정렬이 되었네요.

#+BEGIN_SRC ipython :session :results raw :exports code
df.sort_values('신장(cm)', ascending=False)
#+END_SRC

#+BEGIN_SRC ipython :session :results raw output :exports result
tab(df.sort_values('신장(cm)', ascending=False))
#+END_SRC

#+RESULTS:
|    | 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|----+------+------+------+----------+------------+-------------|
|  0 |    1 |   30 |    1 |      183 |         82 |           1 |
|  9 |   10 |   31 |    1 |      183 |         77 |           3 |
|  5 |    6 |   27 |    1 |      179 |         77 |           1 |
|  2 |    3 |   27 |    1 |      178 |         77 |           2 |
| 15 |   16 |   33 |    1 |      177 |         72 |           2 |
| 13 |   14 |   24 |    1 |      176 |         66 |           3 |
| 11 |   12 |   26 |    1 |      173 |         70 |           2 |
| 12 |   13 |   35 |    1 |      173 |         68 |           3 |
|  3 |    4 |   23 |    1 |      172 |         70 |           2 |
|  7 |    8 |   29 |    1 |      171 |         75 |           3 |
| 14 |   15 |   29 |    2 |      170 |         70 |           2 |
|  6 |    7 |   26 |    1 |      169 |         71 |           1 |
| 18 |   19 |   26 |    1 |      169 |         66 |           2 |
|  4 |    5 |   25 |    1 |      168 |         72 |           3 |
| 17 |   18 |   26 |    1 |      166 |         69 |           3 |
| 10 |   11 |   26 |    2 |      162 |         59 |           1 |
|  1 |    2 |   28 |    2 |      160 |         62 |           3 |
| 16 |   17 |   38 |    2 |      159 |         55 |           1 |
| 19 |   20 |   28 |    2 |      159 |         60 |           2 |
|  8 |    9 |   34 |    2 |      158 |         60 |           2 |


이제 키가 큰 순서대로 정렬이 되었습니다.

여러 컬럼도 정렬이 될까요? 같은 키 내에서는 몸무게 순으로 정렬을 해봅시다.

#+BEGIN_SRC ipython :session :results raw :exports code
df.sort_values(['신장(cm)', '몸무게(kg)'], ascending=False)
#+END_SRC

#+BEGIN_SRC ipython :session :results raw output :exports result
tab(df.sort_values(['신장(cm)', '몸무게(kg)'], ascending=False))
#+END_SRC

#+RESULTS:
|    | 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|----+------+------+------+----------+------------+-------------|
|  0 |    1 |   30 |    1 |      183 |         82 |           1 |
|  9 |   10 |   31 |    1 |      183 |         77 |           3 |
|  5 |    6 |   27 |    1 |      179 |         77 |           1 |
|  2 |    3 |   27 |    1 |      178 |         77 |           2 |
| 15 |   16 |   33 |    1 |      177 |         72 |           2 |
| 13 |   14 |   24 |    1 |      176 |         66 |           3 |
| 11 |   12 |   26 |    1 |      173 |         70 |           2 |
| 12 |   13 |   35 |    1 |      173 |         68 |           3 |
|  3 |    4 |   23 |    1 |      172 |         70 |           2 |
|  7 |    8 |   29 |    1 |      171 |         75 |           3 |
| 14 |   15 |   29 |    2 |      170 |         70 |           2 |
|  6 |    7 |   26 |    1 |      169 |         71 |           1 |
| 18 |   19 |   26 |    1 |      169 |         66 |           2 |
|  4 |    5 |   25 |    1 |      168 |         72 |           3 |
| 17 |   18 |   26 |    1 |      166 |         69 |           3 |
| 10 |   11 |   26 |    2 |      162 |         59 |           1 |
|  1 |    2 |   28 |    2 |      160 |         62 |           3 |
| 19 |   20 |   28 |    2 |      159 |         60 |           2 |
| 16 |   17 |   38 |    2 |      159 |         55 |           1 |
|  8 |    9 |   34 |    2 |      158 |         60 |           2 |

여러 컬럼을 정렬할 때, 컬럼별로 순서를 다르게 할 수 있을까요? 키는 내림차순, 몸무게는 오름차순으로요.

#+BEGIN_SRC ipython :session :results raw :exports code
df.sort_values(['신장(cm)', '몸무게(kg)'], ascending=[False, True])
#+END_SRC

#+BEGIN_SRC ipython :session :results raw output :exports result
tab(df.sort_values(['신장(cm)', '몸무게(kg)'], ascending=[False, True]))
#+END_SRC

#+RESULTS:
|    | 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|----+------+------+------+----------+------------+-------------|
|  9 |   10 |   31 |    1 |      183 |         77 |           3 |
|  0 |    1 |   30 |    1 |      183 |         82 |           1 |
|  5 |    6 |   27 |    1 |      179 |         77 |           1 |
|  2 |    3 |   27 |    1 |      178 |         77 |           2 |
| 15 |   16 |   33 |    1 |      177 |         72 |           2 |
| 13 |   14 |   24 |    1 |      176 |         66 |           3 |
| 12 |   13 |   35 |    1 |      173 |         68 |           3 |
| 11 |   12 |   26 |    1 |      173 |         70 |           2 |
|  3 |    4 |   23 |    1 |      172 |         70 |           2 |
|  7 |    8 |   29 |    1 |      171 |         75 |           3 |
| 14 |   15 |   29 |    2 |      170 |         70 |           2 |
| 18 |   19 |   26 |    1 |      169 |         66 |           2 |
|  6 |    7 |   26 |    1 |      169 |         71 |           1 |
|  4 |    5 |   25 |    1 |      168 |         72 |           3 |
| 17 |   18 |   26 |    1 |      166 |         69 |           3 |
| 10 |   11 |   26 |    2 |      162 |         59 |           1 |
|  1 |    2 |   28 |    2 |      160 |         62 |           3 |
| 16 |   17 |   38 |    2 |      159 |         55 |           1 |
| 19 |   20 |   28 |    2 |      159 |         60 |           2 |
|  8 |    9 |   34 |    2 |      158 |         60 |           2 |

이렇게 하면 되는군요.


** 기초 통계

가장 간단히, 수강생들의 키에 대한 최소, 최대, 평균과 표준편차 등을 알아봅시다.

#+BEGIN_SRC ipython :session :exports both :results raw
df['신장(cm)'].describe()
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
  count     20.00000
  mean     170.25000
  std        7.81951
  min      158.00000
  25%      165.00000
  50%      170.50000
  75%      176.25000
  max      183.00000
  Name: 신장(cm), dtype: float64
#+END_EXAMPLE


** 빈도 분석

이번에는, 데이터별로 빈도가 어떻게 되는지 살펴봅시다.

우선 성별 비율이 어떻게 되는지 살펴봅니다. 성별 각각의 빈도는 아래와 같이 살펴볼 수 있습니다.

#+BEGIN_SRC ipython :session :exports both :results raw
df['성별'].value_counts()
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
  1    14
  2     6
  Name: 성별, dtype: int64
#+END_EXAMPLE

빈도 대신 비율을 살펴보려면 아래와 같이 ~normalize~ 옵션을 추가합니다. 최대 1의 값을 가지는 소숫점이 나오고, 100을 곱하면 퍼센트로 나타낼 수 있습니다.

#+BEGIN_SRC ipython :session :exports both :results raw
df['성별'].value_counts(normalize=True)
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
  1    0.7
  2    0.3
  Name: 성별, dtype: float64
#+END_EXAMPLE

#+BEGIN_SRC ipython :session :exports both :results raw
df['성별'].value_counts(normalize=True) * 100
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
  1    70.0
  2    30.0
  Name: 성별, dtype: float64
#+END_EXAMPLE

성별에 대한 빈도와 비율을 함께 표시해봅시다.

#+BEGIN_SRC ipython :session :exports code :results raw
freq = df['성별'].value_counts()
ratio = df['성별'].value_counts(normalize=True) * 100
df_freq = pd.DataFrame([freq, ratio], index=['빈도', '비율(%)'])
df_freq
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_freq)
#+END_SRC

#+RESULTS:
|         |  1 |  2 |
|---------+----+----|
| 빈도    | 14 |  6 |
| 비율(%) | 70 | 30 |

빈도를 나타내는 ~series~ 를 하나, 비율을 나타내는 ~series~ 를 하나 생성하고, ~DataFrame~ 을 사용하여 두 요소를 하나의 표로 묶어줍니다.


** 피벗 테이블

엑셀에서 편리하게 사용하는 기능 중 하나가 피벗 테이블입니다. 

[[file:assets/excel-pivot.png]]

pandas로는 피벗 테이블을 어떻게 만들까요? 우선, 피벗 테이블을 사용해서도 앞에서 구했던 빈도를 구할 수 있습니다.

#+BEGIN_SRC ipython :session :exports both :results raw
pd.pivot_table(df, index='성별', aggfunc='size')
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
성별
  1    14
  2     6
  dtype: int64
#+END_EXAMPLE

아래와 같이 성별에 따른 값의 차이를 피벗 테이블로 살펴봅시다.

#+BEGIN_SRC ipython :session :exports code :results raw
df_pv_1 = pd.pivot_table(df, index='성별')
df_pv_1
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_pv_1)
#+END_SRC

#+RESULTS:
| 성별 |    나이 | 몸무게(kg) |    번호 | 신장(cm) | 즐기는 음식 |
|------+---------+------------+---------+----------+-------------|
|    1 | 27.7143 |    72.2857 | 9.71429 |  174.071 |     2.21429 |
|    2 |    30.5 |         61 | 12.3333 |  161.333 |     1.83333 |

소숫점 자릿수를 일치시켜봅시다.

#+BEGIN_SRC ipython :session :exports code :results raw
df_pv_1 = pd.pivot_table(df, index='성별')
df_pv_1.apply(lambda x: round(x, 2))
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_pv_1.apply(lambda x: round(x, 2)))
#+END_SRC

#+RESULTS:
| 성별 |  나이 | 몸무게(kg) |  번호 | 신장(cm) | 즐기는 음식 |
|------+-------+------------+-------+----------+-------------|
|    1 | 27.71 |      72.29 |  9.71 |   174.07 |        2.21 |
|    2 | 30.50 |      61.00 | 12.33 |   161.33 |        1.83 |

~apply~ 함수는 ~DataFrame~ 의 각 셀에 인자로 오는 함수를 적용한 결과로 이루어진 새 ~DataFrame~ 을 반환합니다.

이번에는 성별과 함께 좋아하는 음식별로 연령이나 몸무게 등에 차이가 있는지 살펴봅시다.

#+BEGIN_SRC ipython :session :exports code :results raw 
df_pv_2 = pd.pivot_table(df, index=['성별', '즐기는 음식'])
df_pv_2.apply(lambda x: round(x, 2))
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_pv_2.apply(lambda x: round(x, 2)))
#+END_SRC

#+RESULTS:
|        |  나이 | 몸무게(kg) |  번호 | 신장(cm) |
|--------+-------+------------+-------+----------|
| (1, 1) | 27.67 |      76.67 |  4.67 |   177.00 |
| (1, 2) | 27.00 |      71.00 | 10.80 |   173.80 |
| (1, 3) | 28.33 |      71.17 | 11.33 |   172.83 |
| (2, 1) | 32.00 |      57.00 | 14.00 |   160.50 |
| (2, 2) | 30.33 |      63.33 | 14.67 |   162.33 |
| (2, 3) | 28.00 |      62.00 |  2.00 |   160.00 |

#+BEGIN_SRC ipython :session :exports both :results raw
df_pv_3 = pd.pivot_table(df, index='성별', columns='즐기는 음식', values='몸무게(kg)')
df_pv_3.apply(lambda x: round(x, 1))
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_pv_3.apply(lambda x: round(x, 1)))
#+END_SRC

#+RESULTS:
| 성별 |    1 |    2 |    3 |
|------+------+------+------|
|    1 | 76.7 | 71.0 | 71.2 |
|    2 | 57.0 | 63.3 | 62.0 |


** Vlookup

엑셀에서 피벗과 더불어 중급 기술로 여겨지는 것 중 하나가 ~vlookup~ 이죠. 데이터베이스 용어로 하면 JOIN 입니다.

pandas에서는 ~merge~ 함수를 사용할 수 있습니다.

우선 ~vlookup~ 의 대상이 될 테이블을 만듭니다.

#+BEGIN_SRC ipython :session :results raw :exports code
  import pandas as pd
  df_food = pd.DataFrame(['한식', '일식', '중식'], index=[1, 2, 3], columns=['음식이름'])
  df_food
#+END_SRC

#+BEGIN_SRC ipython :session :results raw output :exports result
tab(df_food)
#+END_SRC

#+RESULTS:
|   | 음식이름 |
|---+----------|
| 1 | 한식     |
| 2 | 일식     |
| 3 | 중식     |

#+BEGIN_SRC ipython :session :results raw :exports code
  df_merged = pd.merge(df, df_food, how='left', left_on='즐기는 음식', right_index=True)
  df_merged
#+END_SRC

#+BEGIN_SRC ipython :session :results raw output :exports result
  tab(df_merged)
#+END_SRC

#+RESULTS:
|    | 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 | 음식이름 |
|----+------+------+------+----------+------------+-------------+----------|
|  0 |    1 |   30 |    1 |      183 |         82 |           1 | 한식     |
|  1 |    2 |   28 |    2 |      160 |         62 |           3 | 중식     |
|  2 |    3 |   27 |    1 |      178 |         77 |           2 | 일식     |
|  3 |    4 |   23 |    1 |      172 |         70 |           2 | 일식     |
|  4 |    5 |   25 |    1 |      168 |         72 |           3 | 중식     |
|  5 |    6 |   27 |    1 |      179 |         77 |           1 | 한식     |
|  6 |    7 |   26 |    1 |      169 |         71 |           1 | 한식     |
|  7 |    8 |   29 |    1 |      171 |         75 |           3 | 중식     |
|  8 |    9 |   34 |    2 |      158 |         60 |           2 | 일식     |
|  9 |   10 |   31 |    1 |      183 |         77 |           3 | 중식     |
| 10 |   11 |   26 |    2 |      162 |         59 |           1 | 한식     |
| 11 |   12 |   26 |    1 |      173 |         70 |           2 | 일식     |
| 12 |   13 |   35 |    1 |      173 |         68 |           3 | 중식     |
| 13 |   14 |   24 |    1 |      176 |         66 |           3 | 중식     |
| 14 |   15 |   29 |    2 |      170 |         70 |           2 | 일식     |
| 15 |   16 |   33 |    1 |      177 |         72 |           2 | 일식     |
| 16 |   17 |   38 |    2 |      159 |         55 |           1 | 한식     |
| 17 |   18 |   26 |    1 |      166 |         69 |           3 | 중식     |
| 18 |   19 |   26 |    1 |      169 |         66 |           2 | 일식     |
| 19 |   20 |   28 |    2 |      159 |         60 |           2 | 일식     |

왼쪽 테이블, 즉 ~df~ 의 '즐기는 음식' 컬럼과, 오른쪽 테이블, 즉 ~df_foot~ 테이블의 인덱스 컬럼을 비교하여, 같은 row인 경우 두 row를 결합합니다.


** Correlation

이번에는 컬럼간의 상관관계를 구해볼까요?

#+BEGIN_SRC ipython :session :exports code :results raw
df.corr()
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df.corr())
#+END_SRC

#+RESULTS:
|             |      번호 |      나이 |      성별 |  신장(cm) | 몸무게(kg) | 즐기는 음식 |
|-------------+-----------+-----------+-----------+-----------+------------+-------------|
| 번호        |         1 |  0.228479 |  0.208141 |  -0.31344 |  -0.495021 |   0.0790217 |
| 나이        |  0.228479 |         1 |  0.334697 | -0.147492 |   -0.23975 |   -0.104107 |
| 성별        |  0.208141 |  0.334697 |         1 | -0.765901 |  -0.751269 |   -0.227276 |
| 신장(cm)    |  -0.31344 | -0.147492 | -0.765901 |         1 |   0.882939 |    0.038434 |
| 몸무게(kg)  | -0.495021 |  -0.23975 | -0.751269 |  0.882939 |          1 |   0.0680821 |
| 즐기는 음식 | 0.0790217 | -0.104107 | -0.227276 |  0.038434 |  0.0680821 |           1 |

사실 지금까지 데이터를 다루는 과정에서 불편한 점이 있었는데, 바로 카테고리 값들을 숫자값처럼 인식하는 것이었습니다. 피벗 테이블에서 성별이나 번호에 대한 평균값을 표시해주는 것처럼요.

이 시점에서 각 컬럼에 올바른 데이터 타입을 지정해봅시다.

#+BEGIN_SRC ipython :session :exports code :results raw
  df_dtype = pd.read_excel('assets/엑셀과정실습생.xlsx', sheet_name='Sheet1',
                           index_col=0,
                           dtype={'번호': 'object', '성별': 'object', '즐기는 음식': 'object'})
  df_dtype
#+END_SRC

번호, 성별, 즐기는 음식은 문자열 타입이라고 지정해주었습니다.

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_dtype)
#+END_SRC

#+RESULTS:
| 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|------+------+------+----------+------------+-------------|
|    1 |   30 |    1 |      183 |         82 |           1 |
|    2 |   28 |    2 |      160 |         62 |           3 |
|    3 |   27 |    1 |      178 |         77 |           2 |
|    4 |   23 |    1 |      172 |         70 |           2 |
|    5 |   25 |    1 |      168 |         72 |           3 |
|    6 |   27 |    1 |      179 |         77 |           1 |
|    7 |   26 |    1 |      169 |         71 |           1 |
|    8 |   29 |    1 |      171 |         75 |           3 |
|    9 |   34 |    2 |      158 |         60 |           2 |
|   10 |   31 |    1 |      183 |         77 |           3 |
|   11 |   26 |    2 |      162 |         59 |           1 |
|   12 |   26 |    1 |      173 |         70 |           2 |
|   13 |   35 |    1 |      173 |         68 |           3 |
|   14 |   24 |    1 |      176 |         66 |           3 |
|   15 |   29 |    2 |      170 |         70 |           2 |
|   16 |   33 |    1 |      177 |         72 |           2 |
|   17 |   38 |    2 |      159 |         55 |           1 |
|   18 |   26 |    1 |      166 |         69 |           3 |
|   19 |   26 |    1 |      169 |         66 |           2 |
|   20 |   28 |    2 |      159 |         60 |           2 |

이 ~DataFrame~ 에 대해서 상관관계를 구해볼까요?

#+BEGIN_SRC ipython :session :exports code :results raw
df_dtype.corr()
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_dtype.corr())
#+END_SRC

#+RESULTS:
|            |      나이 |  신장(cm) | 몸무게(kg) |
|------------+-----------+-----------+------------|
| 나이       |         1 | -0.147492 |   -0.23975 |
| 신장(cm)   | -0.147492 |         1 |   0.882939 |
| 몸무게(kg) |  -0.23975 |  0.882939 |          1 |

이제 연속된 값을 나타내는 컬럼에 대해서만 상관관계를 구한 것을 볼 수 있습니다.

앞서 살펴보았던 피벗테이블도 어떻게 달라졌는지 살펴볼까요?

#+BEGIN_SRC ipython :session :exports code :results raw
pd.pivot_table(df_dtype, index='성별')
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(pd.pivot_table(df_dtype, index='성별'))
#+END_SRC

#+RESULTS:
| 성별 |    나이 | 몸무게(kg) | 신장(cm) |
|------+---------+------------+----------|
|    1 | 27.7143 |    72.2857 |  174.071 |
|    2 | 30.5000 |    61.0000 |  161.333 |

역시 연속값을 가지는 컬럼들만 대상으로 피벗테이블을 만듭니다.

여러 층위의 index에 대해서도 그러합니다.

#+BEGIN_SRC ipython :session :exports code :results raw
pd.pivot_table(df_dtype, index=['성별', '즐기는 음식'])
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(pd.pivot_table(df_dtype, index=['성별', '즐기는 음식']))
#+END_SRC

#+RESULTS:
|        |    나이 | 몸무게(kg) | 신장(cm) |
|--------+---------+------------+----------|
| (1, 1) | 27.6667 |    76.6667 |  177.000 |
| (1, 2) | 27.0000 |    71.0000 |  173.800 |
| (1, 3) | 28.3333 |    71.1667 |  172.833 |
| (2, 1) | 32.0000 |    57.0000 |  160.500 |
| (2, 2) | 30.3333 |    63.3333 |  162.333 |
| (2, 3) | 28.0000 |    62.0000 |  160.000 |


** Row 필터링

값을 기준으로 필터링하고 싶은 경우에는 어떻게 할까요? 너무 특이한 값을 가지는 아웃라이어를 제거한다던지 말이죠.

몸무게가 80 이상인 사람은 제외하도록 해봅시다.

우선, 어떤 사람이 몸무게가 80 이상인지 확인합니다.

#+BEGIN_SRC ipython :session :exports both :results raw
df_dtype['몸무게(kg)'] < 80
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
번호
  1     False
  2      True
  3      True
  4      True
  5      True
  6      True
  7      True
  8      True
  9      True
  10     True
  11     True
  12     True
  13     True
  14     True
  15     True
  16     True
  17     True
  18     True
  19     True
  20     True
  Name: 몸무게(kg), dtype: bool
#+END_EXAMPLE

이 boolean 배열을 ~df_dtype~ 에게 전달합니다.

#+BEGIN_SRC ipython :session :exports code :results raw
df_dtype[df_dtype['몸무게(kg)'] <= 80]
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_dtype[df_dtype['몸무게(kg)'] <= 80])
#+END_SRC

#+RESULTS:
| 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 |
|------+------+------+----------+------------+-------------|
|    2 |   28 |    2 |      160 |         62 |           3 |
|    3 |   27 |    1 |      178 |         77 |           2 |
|    4 |   23 |    1 |      172 |         70 |           2 |
|    5 |   25 |    1 |      168 |         72 |           3 |
|    6 |   27 |    1 |      179 |         77 |           1 |
|    7 |   26 |    1 |      169 |         71 |           1 |
|    8 |   29 |    1 |      171 |         75 |           3 |
|    9 |   34 |    2 |      158 |         60 |           2 |
|   10 |   31 |    1 |      183 |         77 |           3 |
|   11 |   26 |    2 |      162 |         59 |           1 |
|   12 |   26 |    1 |      173 |         70 |           2 |
|   13 |   35 |    1 |      173 |         68 |           3 |
|   14 |   24 |    1 |      176 |         66 |           3 |
|   15 |   29 |    2 |      170 |         70 |           2 |
|   16 |   33 |    1 |      177 |         72 |           2 |
|   17 |   38 |    2 |      159 |         55 |           1 |
|   18 |   26 |    1 |      166 |         69 |           3 |
|   19 |   26 |    1 |      169 |         66 |           2 |
|   20 |   28 |    2 |      159 |         60 |           2 |

몸무게가 80kg 이상인 항목은 제외된 것을 볼 수 있습니다. (여기서, df_dtype 자체는 변하지 않고, 항목이 제외된 새 DataFrame이 반환된다는 것에 주의하세요)


** 컬럼 추가, 변형

기존의 컬럼들을 사용해서 새로운 컬럼을 추가하고 싶으면 어떻게 할까요? 키와 몸무게를 사용해서 BMI 지수를 한번 구해봅시다.

우선, BMI 지수는 키를 cm 대신 m로 표시해야 합니다.

#+BEGIN_SRC ipython :session :exports both :results raw
df_dtype['신장(cm)'] / 100
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
번호
  1     1.83
  2     1.60
  3     1.78
  4     1.72
  5     1.68
  6     1.79
  7     1.69
  8     1.71
  9     1.58
  10    1.83
  11    1.62
  12    1.73
  13    1.73
  14    1.76
  15    1.70
  16    1.77
  17    1.59
  18    1.66
  19    1.69
  20    1.59
  Name: 신장(cm), dtype: float64
#+END_EXAMPLE

이 컬럼을 =신장(m)= 이라는 컬럼으로 추가해봅시다.


#+BEGIN_SRC ipython :session :exports code :results raw
df_dtype['신장(m)'] = df_dtype['신장(cm)'] / 100
df_dtype
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results raw output
tab(df_dtype)
#+END_SRC

#+RESULTS:
| 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 | 신장(m) |
|------+------+------+----------+------------+-------------+---------|
|    1 |   30 |    1 |      183 |         82 |           1 |    1.83 |
|    2 |   28 |    2 |      160 |         62 |           3 |     1.6 |
|    3 |   27 |    1 |      178 |         77 |           2 |    1.78 |
|    4 |   23 |    1 |      172 |         70 |           2 |    1.72 |
|    5 |   25 |    1 |      168 |         72 |           3 |    1.68 |
|    6 |   27 |    1 |      179 |         77 |           1 |    1.79 |
|    7 |   26 |    1 |      169 |         71 |           1 |    1.69 |
|    8 |   29 |    1 |      171 |         75 |           3 |    1.71 |
|    9 |   34 |    2 |      158 |         60 |           2 |    1.58 |
|   10 |   31 |    1 |      183 |         77 |           3 |    1.83 |
|   11 |   26 |    2 |      162 |         59 |           1 |    1.62 |
|   12 |   26 |    1 |      173 |         70 |           2 |    1.73 |
|   13 |   35 |    1 |      173 |         68 |           3 |    1.73 |
|   14 |   24 |    1 |      176 |         66 |           3 |    1.76 |
|   15 |   29 |    2 |      170 |         70 |           2 |     1.7 |
|   16 |   33 |    1 |      177 |         72 |           2 |    1.77 |
|   17 |   38 |    2 |      159 |         55 |           1 |    1.59 |
|   18 |   26 |    1 |      166 |         69 |           3 |    1.66 |
|   19 |   26 |    1 |      169 |         66 |           2 |    1.69 |
|   20 |   28 |    2 |      159 |         60 |           2 |    1.59 |

이제 같은 방식으로 BMI 지수를 구해볼까요?


#+BEGIN_SRC ipython :session :exports code :results raw
df_dtype['BMI'] = round(df_dtype['몸무게(kg)'] / pow(df_dtype['신장(m)'], 2), 1)
df_dtype
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results raw output
tab(df_dtype)
#+END_SRC

#+RESULTS:
| 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 | 신장(m) |  BMI |
|------+------+------+----------+------------+-------------+---------+------|
|    1 |   30 |    1 |      183 |         82 |           1 |    1.83 | 24.5 |
|    2 |   28 |    2 |      160 |         62 |           3 |     1.6 | 24.2 |
|    3 |   27 |    1 |      178 |         77 |           2 |    1.78 | 24.3 |
|    4 |   23 |    1 |      172 |         70 |           2 |    1.72 | 23.7 |
|    5 |   25 |    1 |      168 |         72 |           3 |    1.68 | 25.5 |
|    6 |   27 |    1 |      179 |         77 |           1 |    1.79 |   24 |
|    7 |   26 |    1 |      169 |         71 |           1 |    1.69 | 24.9 |
|    8 |   29 |    1 |      171 |         75 |           3 |    1.71 | 25.6 |
|    9 |   34 |    2 |      158 |         60 |           2 |    1.58 |   24 |
|   10 |   31 |    1 |      183 |         77 |           3 |    1.83 |   23 |
|   11 |   26 |    2 |      162 |         59 |           1 |    1.62 | 22.5 |
|   12 |   26 |    1 |      173 |         70 |           2 |    1.73 | 23.4 |
|   13 |   35 |    1 |      173 |         68 |           3 |    1.73 | 22.7 |
|   14 |   24 |    1 |      176 |         66 |           3 |    1.76 | 21.3 |
|   15 |   29 |    2 |      170 |         70 |           2 |     1.7 | 24.2 |
|   16 |   33 |    1 |      177 |         72 |           2 |    1.77 |   23 |
|   17 |   38 |    2 |      159 |         55 |           1 |    1.59 | 21.8 |
|   18 |   26 |    1 |      166 |         69 |           3 |    1.66 |   25 |
|   19 |   26 |    1 |      169 |         66 |           2 |    1.69 | 23.1 |
|   20 |   28 |    2 |      159 |         60 |           2 |    1.59 | 23.7 |


종종 연속된 값을 일정 범주로 구분해야 하는 경우가 있습니다. 이를테면 13세를 10대, 23세를 20대 이렇게 말이죠. 이런건 어떻게 처리할까요?

우선, 연속된 연령값을 연령대로 구분해주는 함수를 만들어봅시다.

#+BEGIN_SRC ipython :session :exports both :results output
def categorize_age(age):
    return '{}~{}세'.format(age // 5 * 5, (age // 5 + 1) * 5-1)

print(categorize_age(35))
print(categorize_age(31))
print(categorize_age(28))
#+END_SRC

#+RESULTS:
: 35~39세
: 30~34세
: 25~29세

apply 함수는, 원소 하나 하나에 주어진 함수를 대입해서 결과를 반환해줍니다.


#+BEGIN_SRC ipython :session :exports both :results raw
df_dtype['나이'].apply(categorize_age)
#+END_SRC

#+RESULTS:
#+BEGIN_EXAMPLE
번호
  1     30~34세
  2     25~29세
  3     25~29세
  4     20~24세
  5     25~29세
  6     25~29세
  7     25~29세
  8     25~29세
  9     30~34세
  10    30~34세
  11    25~29세
  12    25~29세
  13    35~39세
  14    20~24세
  15    25~29세
  16    30~34세
  17    35~39세
  18    25~29세
  19    25~29세
  20    25~29세
  Name: 나이, dtype: object
#+END_EXAMPLE

이 결과를 컬럼으로 추가합니다.

#+BEGIN_SRC ipython :session :exports code :results raw
df_dtype['연령대'] = df_dtype['나이'].apply(categorize_age)
df_dtype
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_dtype)
#+END_SRC

#+RESULTS:
| 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 | 신장(m) |  BMI | 연령대  |
|------+------+------+----------+------------+-------------+---------+------+---------|
|    1 |   30 |    1 |      183 |         82 |           1 |    1.83 | 24.5 | 30~34세 |
|    2 |   28 |    2 |      160 |         62 |           3 |     1.6 | 24.2 | 25~29세 |
|    3 |   27 |    1 |      178 |         77 |           2 |    1.78 | 24.3 | 25~29세 |
|    4 |   23 |    1 |      172 |         70 |           2 |    1.72 | 23.7 | 20~24세 |
|    5 |   25 |    1 |      168 |         72 |           3 |    1.68 | 25.5 | 25~29세 |
|    6 |   27 |    1 |      179 |         77 |           1 |    1.79 |   24 | 25~29세 |
|    7 |   26 |    1 |      169 |         71 |           1 |    1.69 | 24.9 | 25~29세 |
|    8 |   29 |    1 |      171 |         75 |           3 |    1.71 | 25.6 | 25~29세 |
|    9 |   34 |    2 |      158 |         60 |           2 |    1.58 |   24 | 30~34세 |
|   10 |   31 |    1 |      183 |         77 |           3 |    1.83 |   23 | 30~34세 |
|   11 |   26 |    2 |      162 |         59 |           1 |    1.62 | 22.5 | 25~29세 |
|   12 |   26 |    1 |      173 |         70 |           2 |    1.73 | 23.4 | 25~29세 |
|   13 |   35 |    1 |      173 |         68 |           3 |    1.73 | 22.7 | 35~39세 |
|   14 |   24 |    1 |      176 |         66 |           3 |    1.76 | 21.3 | 20~24세 |
|   15 |   29 |    2 |      170 |         70 |           2 |     1.7 | 24.2 | 25~29세 |
|   16 |   33 |    1 |      177 |         72 |           2 |    1.77 |   23 | 30~34세 |
|   17 |   38 |    2 |      159 |         55 |           1 |    1.59 | 21.8 | 35~39세 |
|   18 |   26 |    1 |      166 |         69 |           3 |    1.66 |   25 | 25~29세 |
|   19 |   26 |    1 |      169 |         66 |           2 |    1.69 | 23.1 | 25~29세 |
|   20 |   28 |    2 |      159 |         60 |           2 |    1.59 | 23.7 | 25~29세 |


#+BEGIN_SRC ipython :session :exports code :results raw
df_cat_pv = pd.pivot_table(df_dtype, index='연령대', columns='즐기는 음식', values='몸무게(kg)')
df_cat_pv.apply(lambda x: round(x, 1))
#+END_SRC

#+BEGIN_SRC ipython :session :exports result :results output raw
tab(df_cat_pv.apply(lambda x: round(x, 1)))
#+END_SRC
#+RESULTS:
| 연령대  |    1 |    2 |    3 |
|---------+------+------+------|
| 20~24세 |  nan | 70.0 | 66.0 |
| 25~29세 | 69.0 | 68.6 | 69.5 |
| 30~34세 | 82.0 | 66.0 | 77.0 |
| 35~39세 | 55.0 |  nan | 68.0 |


더 이상 필요 없는 컬럼을 지울 때는, =dict= 에서 =key= 를 삭제할 때처럼, ~a_dict.pop('나이')~, 혹은 ~del a_dict['나이']~ 를 사용할 수 있습니다.

#+BEGIN_SRC ipython :session :results raw :exports both
df_dtype[['신장(m)', '몸무게(kg)', 'BMI']]
#+END_SRC




** 엑셀로 저장하기

지금까지 가공한 DataFrame을 다시 엑셀 파일로 저장해봅시다.

#+BEGIN_SRC ipython :session :exports code :results raw
  df_dtype.to_excel('outputs/실습생_컬럼추가.xlsx')
#+END_SRC


** 연습문제

앞에서 구했던 BMI 지수를 가지고, 비만도를 나타내는 컬럼을 DataFrame에 추가해보세요.

|--------------------------+-------------|
| 비만도                   | 구간        |
|--------------------------+-------------|
| 고도 비만                | 35 이상     |
| 중등도 비만 (2단계 비만) | 30 ~ 35     |
| 경도 비만 (1단계 비만)   | 25 ~ 30     |
| 과체중                   | 23 - 24.9   |
| 정상                     | 18.5 - 22.9 |
| 저체중                   | 18.5 미만   |
|--------------------------+-------------|

비만 정도와 좋아하는 음식 사이에 어떤 연관성이 있는지 한번 살펴보세요.


#+BEGIN_SRC ipython :session :exports none :results output raw
  def fat_category(val):
      if val >= 35:
          return '고도 비만'
      if 30 <= val < 35:
          return '중등도 비만'
      if 25 <= val < 30:
          return '경도 비만'
      if 23 <= val < 25:
          return '과체중'
      if 18.5 <= val < 23:
          return '정상'
      return '저체중'

  df_dtype['비만도'] = df_dtype['BMI'].apply(fat_category)
  tab(df_dtype)
#+END_SRC

#+RESULTS:
| 번호 | 나이 | 성별 | 신장(cm) | 몸무게(kg) | 즐기는 음식 | 신장(m) |  BMI | 연령대  | 비만도    |
|------+------+------+----------+------------+-------------+---------+------+---------+-----------|
|    1 |   30 |    1 |      183 |         82 |           1 |    1.83 | 24.5 | 30~34세 | 과체중    |
|    2 |   28 |    2 |      160 |         62 |           3 |     1.6 | 24.2 | 25~29세 | 과체중    |
|    3 |   27 |    1 |      178 |         77 |           2 |    1.78 | 24.3 | 25~29세 | 과체중    |
|    4 |   23 |    1 |      172 |         70 |           2 |    1.72 | 23.7 | 20~24세 | 과체중    |
|    5 |   25 |    1 |      168 |         72 |           3 |    1.68 | 25.5 | 25~29세 | 경도 비만 |
|    6 |   27 |    1 |      179 |         77 |           1 |    1.79 |   24 | 25~29세 | 과체중    |
|    7 |   26 |    1 |      169 |         71 |           1 |    1.69 | 24.9 | 25~29세 | 과체중    |
|    8 |   29 |    1 |      171 |         75 |           3 |    1.71 | 25.6 | 25~29세 | 경도 비만 |
|    9 |   34 |    2 |      158 |         60 |           2 |    1.58 |   24 | 30~34세 | 과체중    |
|   10 |   31 |    1 |      183 |         77 |           3 |    1.83 |   23 | 30~34세 | 과체중    |
|   11 |   26 |    2 |      162 |         59 |           1 |    1.62 | 22.5 | 25~29세 | 정상      |
|   12 |   26 |    1 |      173 |         70 |           2 |    1.73 | 23.4 | 25~29세 | 과체중    |
|   13 |   35 |    1 |      173 |         68 |           3 |    1.73 | 22.7 | 35~39세 | 정상      |
|   14 |   24 |    1 |      176 |         66 |           3 |    1.76 | 21.3 | 20~24세 | 정상      |
|   15 |   29 |    2 |      170 |         70 |           2 |     1.7 | 24.2 | 25~29세 | 과체중    |
|   16 |   33 |    1 |      177 |         72 |           2 |    1.77 |   23 | 30~34세 | 과체중    |
|   17 |   38 |    2 |      159 |         55 |           1 |    1.59 | 21.8 | 35~39세 | 정상      |
|   18 |   26 |    1 |      166 |         69 |           3 |    1.66 |   25 | 25~29세 | 경도 비만 |
|   19 |   26 |    1 |      169 |         66 |           2 |    1.69 | 23.1 | 25~29세 | 과체중    |
|   20 |   28 |    2 |      159 |         60 |           2 |    1.59 | 23.7 | 25~29세 | 과체중    |


#+BEGIN_SRC ipython :session :exports none :results output raw
  tab(pd.pivot_table(df_dtype, index='비만도', columns='즐기는 음식', aggfunc='size'))
#+END_SRC

#+RESULTS:
| 비만도    |   1 |   2 | 3 |
|-----------+-----+-----+---|
| 경도 비만 | nan | nan | 3 |
| 과체중    |   3 |   8 | 2 |
| 정상      |   2 | nan | 2 |
