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
