#IO Language
##Day 1

***

##Starting IO
To install IO language in a Debian machine you just need to type in your terminal

    sudo apt-get install iolanguage

For those who like to build the last version from the official repository [here](http://en.wikibooks.org/wiki/Io_Programming/Beginner%27s_Guide/Getting_Started) is a good tutorial how to do it.


After you install the IO language you can type a kind of hello world just to start

    Io> "Hola Muchachos" print
    Hi ho, Io==> Hola Muchachos

Just by looking to the syntax you should figure some differences from much of other you're probably had already worked. This language is based on message passing, so in this simple example what you're really doing is sending the message *Hola Muchachos* to the *object* **print**

IO is a prototype based language, so you don't had the concept of **class**, instead you create object instances based on previous defined objects. Ultimately all the objects will inherit from object **Object**

Lets define a new **Shotgun** object and define some properties (*or slots as they are called in IO*)

    Shotgun := Object clone
    Shotgun ammo := 12
    Shotgun model := "Remington"

If you type **Shotgun** in the interpreter you should see something like this

      Io> Shotgun
      ==>  Shotgun_0xe84e50:
        ammo             = 12
        model            = "Remington"
        type             = "Shotgun"

###Day One Questions

* *Evaluate 1 + 1 and then 1 + "one" . Is Io strongly typed or weakly
typed? Support your answer with code*

If you run the previous command on the Io interpreter you get the following result

    Io> 1+"one"
      Exception: argument 0 to method '+' must be a Number, not a 'Sequence'
        ---------
        message '+' in 'Command Line' on line 1

What this means is that the operator **+** is sensible to the *type* of the variables. It is explicitly expecting the value of "one" to be of type *Number* and not of type *Sequence*. For this reason we can argue that Io is a strong typed language


* *Is 0 true or false? What about the empty string? Is nil true or false?
Support your answer with code.*

To answer this we can use the interpreter force a boolean comparison with the **and** boolean operator. So

    Io> true and false
    ==> false
    Io> true and 0
    ==> true
    Io> true and nil
    ==> false

This means that **0** has the **true** boolean value and the **nil** has a **false** boolean value.

* *How can you tell what slots a prototype supports?*

To *list* all the slots you can do

    Io> Shotgun slotNames
    ==> list(ammo, model, type)

* *What is the difference between = (equals), := (colon equals), and ::=
(colon colon equals)? When would you use each one?*

Lets use the **Shotgun** example to see the diferences. Lets try to define a *boolean* slot called **locked**, lets first try the **=** operator and see what happens

    Io> Shotgun locked = false
    Exception: Slot locked not found. Must define slot using := operator before updating.
    ---------
    message 'updateSlot' in 'Command Line' on line 1

So as wee saw the **=** operator is an assignment one. **=** don't define slots, only set the value of slots previously defined with **:=** or **::=**
The difference between the last two is that the second also defines a setter method for the slot

    Io> Shotgun locked ::=false
    ==> false
    Io> Shotgun
    ==>  Shotgun_0x1d2c620:
      ammo             = 12
      locked           = false
      model            = "Remington"
      setLocked        = method(...)
      type             = "Shotgun"

And to see the setter method working you can type

    Io> Shotgun setLocked(true)
    ==>  Shotgun_0x1d2c620:
      ammo             = 12
      locked           = true
      model            = "Remington"
      setLocked        = method(...)
      type             = "Shotgun"

***

###Aditional Info

[IO Guide](http://iolanguage.org/scm/io/docs/IoGuide.html)

[IO Reference](http://iolanguage.org/scm/io/docs/reference/index.html)

[Balhau 7L7W Github](https://github.com/CodeAndStuff/7l7w)

#IO Language
##Day 2

On this second day of Io language tutorials the first exercise is a classic

###First question

* *A Fibonacci sequence starts with two 1s. Each subsequent number is the sum of the two numbers that came before: 1, 1, 2, 3, 5, 8, 13, 21, and so on. Write a program to find the nth Fibonacci number. fib(1) is 1, and fib(4) is 3. As a bonus, solve the problem with recursion and with loops.*

For this we decide to create a new object

    Fibonacci := Object clone

In this we'll implement the solution in a recursive and non recursive way.

The non recursive way consists in a trivial use of loops by accumulating the previous two iterations of the Fibonacci sequence

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

Looking into the for loop we can see that we start iterating in *3* with an increment of *1* each time. This way it will not run unless the *n>=3*

The recursive method has the same principle but the loop is replaced by a recursive call

    Fibonacci rec := method(n,
      if(n==1 or n==2, return(1))
      return(rec(n-1)+rec(n-2))
    )

In this case we have the loop doing backwards until it reaches the base cases when *n==1 or n==2*

Finally we can check the results by calling

    for(i,1,10, Fibonacci nrec(i) println)
    for(i,1,10, Fibonacci rec(i) println)

***

### Second question
* *How would you change / to return 0 if the denominator is zero?*

For this second challenge all we got to do is
to find the original operator associated with the object **Number** and then replace it from a version that handles correctly the case in which the *0* is on the denominator

    originalOperator := Number getSlot("/")

With the previous code we assign the original */* operator into the slot **originalOperator** now the only thing we need to do is the redefinition of the original operator by doing

    Number / := method (i,
      if(i==0, 0,originalOperator(i))
    )

Finally all we need to do is to check if everything is working as expected

    10 /0 println
    1 / 2 println

***

### Third question

* *Write a program to add up all of the numbers in a two-dimensional
array.*

To this we decide to tackle the problem again by creating a object to encapsulate the operations, this was called **Matrix**

    Matrix := Object clone

To store the bidimentional array e decide to create a slot called data in the **Matrix** object

    Matrix data := List clone

However for the currently question all we got to do is to define a method that we call **sumArray** on the **Matrix** object

    Matrix sumArray := method(
      marray,acc := 0;
      marray foreach(v,acc=acc + v sum); return(acc)
    )

To check if all this is working we can test it by doing

    m1 := Matrix clone

    m1 data =list(list(1,2,3),list(3,4,5))

    m1 sumArray(m1 data) println

All we've done was to create a **Matrix** object called *m1* and fetch the data slot with a bidimentional array and then fetching it to the method that we had created

***

###Fourth question

* *Add a slot called myAverage to a list that computes the average of all the numbers in a list. What happens if there are no numbers in a list? (Bonus: Raise an Io exception if any item in the list is not a number.)*

In this question we create a new slot in the **Matrix** object and call it **myAverage** to compute the *average* of the bidimentional array.

    Matrix myAverage := method(
      l,acc := 0;
      return(acc/(l size))
      l foreach(v,if(v type != Number type,Exception raise("Element not a number"),acc=acc+v))
    )

The method is straightforward. All it do is to iterate over the list, check if it is a number, and then compute the average. The only new thing was the introduction of the

    Exception raise("Element not a number")

when the element on the list don't match a *Number* object signature

Again, for testing purposes, all we need to do is try something like this

    m1 myAverage(list(1,10,3)) println


***

### Fifth question

* *Write a prototype for a two-dimensional list. The dim(x, y) method should allocate a list of y lists that are x elements long. set(x, y,value) should set a value, and get(x, y) should return that value.*

We've start this exerise by creating a new object signature

List2D := List clone

And then all we've got to do is to implement the method to initialize the two-dimentional array

    List2D dim := method(x, y,
        mlist := list


        callback := call evalArgAt(2)

        if(callback isNil, callback := block setScope(call sender))

        for(i, 1, y,
            slist := list
            for(j, 1, x,
                slist append(callback call(i, j))
            )
            mlist append(slist)
        )
        mlist
    )


The method is relatively straightforward. The only catch here is the use of the

    callback := call evalArgAt(2)

to retrieve the callback as a third parameter that will be called every time a new object is inserted in the two-dimentional list.

The rest of the method is a trivial iteration over the two indexes and by populating the list as we expected.

The *set* and *get* are trivial and listed bellow

    List2D setXY := method(l,x,y,val,
      l at(x) atPut(y,val)
    )

    List2D getXY := method(l,x,y,
      l at(x) at(y)
    )

***

### Sixth question

* *Bonus: Write a transpose method so that (new_matrix get(y, x)) ==
matrix get(x, y) on the original list.*

By having the previous method to initialize a bidimentional array it is pretty easy to implement a transpose method in the **Matrix** object

    Matrix transpose := method(
      l1 := List2D clone
      l1 data = data
      return l1 dim(data size,data at(0) size,method(x,y, method(x,y,return data at(y-1) at(x-1))))
    )


For this to work the only change we need to do is to add a data slot in the List2D object

    List2D data := List clone

To check if everything is working you can do


    m2 data println

    m2 transpose() println

    m2 data = m2 transpose()

    m2 transpose() println

This should output something like this

    list(list(1, 2, 3), list(4, 5, 6))
    list(list(1, 4), list(2, 5), list(3, 6))
    list(list(1, 2, 3), list(4, 5, 6))

***

###Seventh question

*  *Write the matrix to a file, and read a matrix from a file*


This is a trivial exercise. All is needed is to search a little bit about the Io File API and then put all the knowledge to practice

Bellow we got the method that save the matrix into a file.

    Matrix saveToFile := method(fileName,
      f := File open(fileName)
      data foreach(d, f write(d join(",")); f write("\n"))
      f flush
      f close
    )

As you can see all it does is to iterate over the *data* **List** object and print it to the file and force the writing of the data before close the file resource

    Matrix loadFromFile := method(filename,
      f := File open(filename)
      line := f readLine
      data=list()
      while(line != nil, data append(line split(",")) ;line = f readLine)
    )

In the case of loading a **Matrix** from a file all we need to do is to iterate over all the lines and then build a **List** object with the contents per line

***

###Last (8) problem

* Write a program that gives you ten tries to guess a random number from 1–100. If you would like, give a hint of "hotter" or "colder"
after the first guess.


Like we did for the previous examples here we created a new *object* called **GuessOrWhat** to implement the game. The object only has one method called **play**. The game is pretty straightforward. All it does is to repeat until you get the value or reach a limit of *10* attempts and keep checking the answer with the previous to measure the distance between the current attempt with the last. Based in these two measures it will tell you if you are closer, *warm*, or not so closer *cold*.


    GuessOrWhat := Object clone

    GuessOrWhat play := method(

    rnumber := (Random value( 99 ) + 1) floor();

    rnumber println


    stdio := File standardInput();

    prev := nil;

    10 repeat(

        "Guess the number in the interval (1..100): " println();

        if(prev == rnumber,break;)

        guess := stdio readLine() asNumber();

        if(
            (guess != rnumber),
            if(
              prev,
              if(
                ((rnumber - guess) abs()) >= ((rnumber - prev) abs()),
                "Colder..." println(),
                "Warmer..." println()
            );
          );
        );
        prev = guess;
    );

      if(
          (guess == rnumber),
          (
              "Great! You've done it!" println();
          ),
          (
              "Keep trying!" println();
          )
      )
    );


To play the game all you got to do is to invoke the following code

    g := GuessOrWhat clone

    g play
