#!/usr/bin/env io

Fibonacci := Object clone

Fibonacci nrec := method( n,
    if(n == 1 or n == 2,return( 1 ))

    n1 := 1
    n2 := 1

    n0 := n1 + n2

    for( i, 3, n, 1,
        n0 = n1 + n2
        n2 = n1
        n1 = n0
    )
    return(n0)
)

Fibonacci rec := method(n,
  if(n==1 or n==2, return(1))
  return(rec(n-1)+rec(n-2))
)

for(i,1,10, Fibonacci nrec(i) println)
for(i,1,10, Fibonacci rec(i) println)


originalOperator := Number getSlot("/")

10 originalOperator(0) println
1 originalOperator(2) println

Number / := method (i,
  if(i==0, 0,originalOperator(i))
)

10 /0 println
1 / 2 println

Matrix := Object clone

Matrix data := List clone

Matrix sumArray := method(
  marray,acc := 0;
  marray foreach(v,acc=acc + v sum); return(acc)
)

Matrix myAverage := method(
  l,acc := 0;
  l foreach(v,if(v type != Number type,Exception raise("Element not a number"),acc=acc+v))
  return(acc/(l size))
)

m1 := Matrix clone

m1 data =list(list(1,2,3),list(3,4,5))

m1 sumArray(m1 data) println

m1 myAverage(list(1,10,3)) println

//List slotNames println

List2D := List clone

List2D dim := method(x, y,
    mlist := list

    callback := call evalArgAt(2)

    for(i, 1, y,
        slist := list
        for(j, 1, x,
            slist append(callback(i, j))
        )
        mlist append(slist)
    )
    mlist
)

List2D setXY := method(l,x,y,val,
  l at(x) atPut(y,val)
)

List2D getXY := method(l,x,y,
  l at(x) at(y)
)

a := List2D dim(2,2,method(a,b,a+b))

a println

List2D setXY(a,0,1,0)

a println

List2D getXY(a,0,1) println

Matrix saveToFile := method(fileName,
  f := File open(fileName)
  data foreach(d, f write(d join(",")); f write("\n"))
  f flush
  f close
)

Matrix loadFromFile := method(filename,
  f := File open(filename)
  line := f readLine
  data=list()
  while(line != nil, data append(line split(",")) ;line = f readLine)
)

Matrix transpose := method(
  return List2D dim(m2 data size,m2 data at(0) size,method(x,y, return m2 data at(y-1) at(x-1)))
)


//File slotNames println


//f := File open("ola.txt")

//f write("1,2,3\n 4,5,6\n 7,8,9")
//f flush
//f close

//f := File open("ola.txt")

//linha := f readLine

//llist := linha split(",")

//llist join(",")  println


m1 := Matrix clone

m1 data = list(list(1,2,3),list(4,5,6))

m1 saveToFile("m1.txt")

m2 := Matrix clone

m2 loadFromFile("m1.txt")

m2 data println

m2 data at(0) size println
m2 data size println

//Sequence slotNames println

m2 transpose() println

m2 data = m2 transpose()

m2 transpose() println
