# Effective Java

## Item 7: Avoid Finalizers

- A finalizer in Java is _not_ the same as a destructor in C++. In Java:
    * memory is reclaimed using garbace collection, and
    * non-memory resources are reclaimed using `try-finally` blocks.
- There's now guarantee that the finalizer will be executed _in time_.
    * The finalizer thread might run with lower priority.
    * The execution of finalizers depends both on the implementation on the specific platform and on the garbage collection (and its implementation).
    * Never do anything time-critical in a finalizer!
    * Don't try to free limited ressources (memory, file descriptors) in a finalizer!
- There's not even a guarantee that the finalizer will be executed _at all_.
    * Never update persistent states in a finalizer!
- Just as `System.gc()` doesn't necessarily run garbage collection, `System.runFinalization()` doesn't run the finalizers.
    * Don't use them, and also don't use the deprecated methods `System.runFinalizersOnExit()` and `Runtime.runFinalizersOnExit()`!
- Uncaught exceptions thrown during finalization are ignored and the finalization will be terminated.
    * The programmer won't even notice that something bad happened.
- Finalizers come with a performance penalty.
- Provide explicit termination methods for classes that need to free non-memory resources.
    * Example: the `close()` method of `InputStream` and `OutputStream`
    * The class implementing `close()` must store it's state and throw an `IllegalStateException` when `close()` was called on it.
    * Termination methods are usually called within a `finally` block to guarantee their execution.
- However, finalizers can be used in some cases:
    * If the client forgot to call the termination method, the finalizer can call it _and should log a warning_ so that the client code can be fixed.
    * When working with native objects, whose memory resources cannot be freed by garbage collection.
- Unlike default constructors, the `finalize()` method of the subclass doesn't call the `finalize()` method of the superclass; it must be called manually (inside a `finally` block).

## Item 8: Obey the general contract when overriding `equals`

- `Object`'s implementation of `equals()` is adequate:
    * if an instance only has to be equals to itself (`equals()` does the same as `==`: `o.equals(o) == (o == o)`),
    * if the `equals()` method of the superclass is appropriate,
    * or if the class is private or package-private and the `equals()` method is never called.
- Classes implementing the singleton pattern and enums don't need an `equals()` method.
- Implementations of `equals()` must adhere to its _general contract_:
    * _Reflexiveness_: for `o != null`, `o.equals(o)` must return `true`.
    * _Symmetry_: for `a != null && b != null`, `a.equals(b)` must return the same as `b.equals(a)`.
    * _Transitivity_: for `x != null && y != null && z != null`, `x.equals(z)` must return `true` if `x.equals(y)` and `y.equals(z)` return `true`.
    * _Consistency_: for `m != null && n != null`, multiple invocations of `m.equals(n)` must return the same (unless information used in `equals()` has been changed in the meantime).
    * _«Non-nullity»_: for `o != null`, `o.equals(null)` must return `false`.
- Many classes (say, those of the Collections framework) depend on `equals()` adhering to the _general contract_!
    * The behaviour of classes violating the _general contract_ is undefined.
- Getting `equals()` right can be hard when using inheritance.
    * Using composition over inheritance makes it easier.
    * `a.equals(b)` should only return true, if `a` and `b` are instances of the same class (`a.getClass() == b.getClass()`).
        - Example: A date might be equals to a timestamp, but a timestamp (containing time information) not to a date, which violates the _summetry_ rule.
    * Don't use unreliable resources in `equals()`.
        - Example: `URL` uses the IP address in its `equals()` implementation, but the IP might change, where's the hostname is still the same (DNS).
- When using the `instanceof` operator (to make sure that instances of the same class are compared), checking for `null` is not necessary.
    * For `o == null`, `o instanceof MyClass` always returns `false`.
- Recipe for high-quality `equals()` methods:
    1. Check for identity (to save time):
        - `if (this == o) return true;`
    2. Use `instanceof`:
        - `if (!(o instanceof MyClass)) return false;`
    3. Cast the object, it's safe now:
        - `MyClass other = (MyClass)o;`
    4. Check all the significant fields for equality:
        - for `boolean`, `int`, `long`, `short`, `byte` and `char`, compare with `==`
        - for `float` and `double`, use `Float.compare()` or `Double.compare()`, respectively: `Float.compare(this.a, other.getA()) == 0`
        - for arrays, iterate over all elements or, better, use `Arrays.equals()`; the element order matters: `Arrays.equals(this.arr, other.getArr()) == true`
        - for object references, first check for null and then call `equals()` on it: `this.field == null ? other.getField() == null : this.field.equals(other.getField()`
        - for performance reasons, first check for fields that are more likely to differ, and immediately return `false` after the first difference is detected.
    5. Write a test case to check the adherence to the _general contract_.
- Make sure to use the correct method signature when overriding `equals()`: `public boolean equals(Object o)`
    * Don't replace `Object` with anything else, otherwise `equals()` won't be called.
    * Use the `@Override` annotation to make sure you have the correct signature.
- Consider letting the IDE generate the `equals()` method.
- Since Java 7, consider using `Objects.equals(this.a, other.getA())` for instance fields.
- When you override `equals()`, also override `hashCode()`.

## Item 9: Always override `hashCode` when you override `equals`

- When overriding `equals()`, always also override the `hashCode()` method, otherwise the class might not work properly for `HashMap`, `HashSet` and `Hashtable`, among others.
- The `hashCode()` implementantion must adhere to the following contract:
    * As long as no information used by `equals()` is changed on an object, it's `hashCode()` method must return the same value in the same execution context.
    * If `a.equals(b)`, `a.hashCode()` must be the same as `b.hashCode()`.
    * If `!a.equals(b)`, `a.hashCode()` and `b.hashCode()` are _not_ required to differ; they should, however, for performance reasons when working with hash tables and the like.
- When two objects that are equal have different hash codes ‒ which is the case when `equals()` has been overridden but not so `hashCode() ‒, the lookup of those objects in a `HashMap` (or the like) might be slower or even fail (return `null`).
- A good `hashCode()` implementation producees equal hash codes for equal objects and unequal hash codes for unequal objects; it can be achieved using this recipe:
    1. Store a constant nonzero value in an integer variable, say, 17.
        - `int result = 17;`
    2. For each significant field `f` (i.e. a field used in `equals()`), do the following:
        a. Compute a hash code for the field:
            - for `boolean`: `int c = (f ? 1 : 0);`
            - for `boolean`, `int`, `short`, `byte` and `char`: `int c = (int)f;`
            - for `long`: `int c = (int)(f ^ (f >>> 32));`
            - for `float`: `int c = Float.floatToIntBits(f);`
            - for `double`: `long l = Double.doubleToLongBits(f); int c = (int)(l ^ (l >>> 32));`
            - for object references: `int c = (f == null ? ' : f.hashCode());`
            - for arrays, apply the same steps for every item ‒ or better use `int c = Arrays.hashCode(f);`
        b. Combine the computed hash code into `result` as follows:
            - `result = 31 * result + c;`
    3. Return `result`
    4. Write a test case to make sure that equal instances have equal hash codes ‒ and unequal instances unequal hash codes.
- 17 and 31 are uneven prime numbers and have some interesting properties that help reduce colissions when computing hash codes. Use those values, unless you are a mathematician.
- Since Java 7, consider using `Objects.hashCode(f1, f2, f3, ...)` by passing all fields that are also used in `equals()`.
- Don't try to optimize `hashCode()` for performance. _Good_ hash codes are more important than _quickly generated_ hash codes, for any computation time saved for creating worse hash codes can make `HashMap` (et al.) perform worse.
