# Effective Exception Handling

These guidelines have been extracted from Joshua Bloch's _Effective Java_ (3rd
Edition), Chapter 10 (Items 69-75).

## Exceptions for Exceptional Conditions (Item 69)

**Do not** use exceptions for control flow:

```java
int sum = 0, i = 0;
while (true) {
    try {
        sum += numbers[i++];
    } catch (ArrayIndexOutOfBoundsException ex) {
        return sum;
    }
}
```

**Do instead** provide and use API that supports regular control flow:

```java
while (iterator.hasNext()) {
    // next() could cause an Exception, hasNext() makes sure it won't
    iterator.next();
}
```

As a rule of thumb: The happy path should never go through a `catch` block.

## Checked and Unchecked Exceptions (Item 70)

**Do not** catch exceptions you cannot recover from:

```java
try {
    memoryIndex.indexEverything();
} catch (OutOfMemoryError err) {
    System.gc(); // hope that helps...
    memoryIndex.indexEverything(); // try again
}
```

**Do instead** make sure all the preconditions are met so that no exception is
to be expected.

As a rule of thumb:

- Use checked exceptions if the caller has a reasonable chance to recover.
- Use unchecked exceptions to indicate programming errors by the caller.

**Do not** extend `java.lang.Error` to define your own unchecked exceptions.

**Do instead** extend `java.lang.RuntimeException`―if you really need a
specialed unchecked exception.

**Do not** throw and catch `Exception`, `Throwable`, `RuntimeException` and `Error`.

**Do instead** throw subclasses of `Exception` and `RuntimeException` and leave
`RuntimeException`s and `Error`s uncaught―and fix your client code instead.

## Overuse of Checked Exceptions (Item 71)

**Do not** make your API unpleasant to use by throwing too many checked
exceptions, which all need to be caught:

```java
try {
    db.save(customer);
} catch (CustomerDeletedInTheMeantimeException | DBConnectionLostException
        | NetworkConnectionLostException | HarddiskCrashException ex) {
    logger.error(ex); // won't happen anyway...
}
```

**Do instead** ask yourself how the caller could react to an exception before
throwing it, or consider returning a `java.util.Optional<T>` value.

## Standard Exceptions (Item 72)

**Do not** reinvent the wheel by creating lots of custom exception classes.

**Do instead** reuse exceptions provided by the Java standard library:

- `IllegalArgumentException`: the method cannot handle the parameters provided
  (`null` or negative values)
- `IllegalStateException`: the recipient object hasn't been initialized
  properly
- `NullPointerException`: a value needed for the operation is `null`
- `IndexOutOfBoundsException`: a index parameter is out of range
- `UnsupportedOperationException`: if a implementation doesn't fully implement
  an interface
- `ArithmeticException`: a calculation failed (say, square root of -1 with
  rational numbers)
- `NumberFormatException`: numeric input provided as a string cannot be parsed
  to a number

Consult the exception's API documentation to make sure you use it as intended.
Don't just pick it if the name has a rough similarity with the error condition
at hand.

## Exceptions Appropriate to Abstraction (Item 73)

**Do not** throw low-level exceptions from high-level APIs:

```java
try {
    JSON config = JSON.parse("config.json");
} catch (FileNotFoundException | IOException | UnsupportedEncodingException ex) {
}
```

**Do instead** wrap low-level exceptions to serve the caller high-level exceptions:

```java
public static JSON parse(String filename) throws JSONException {
    try {
        // parsing logic
    } catch (FileNotFoundException fnfEx) {
        throw new JSONException(filename + " not found.", fnfEx);
    } catch (IOException ioex) {
        throw new JSONException("error processing " + filename, ioEx);
    } catch (UnsupportedEncodingException ueEx) {
        throw new JSONException(filename + " is not UTF-8 encoded", ueEx);
    }
}
```

If the original exception is chained (see the _Decorator Pattern_), the full
stack-trace is preserved for the caller. Make sure to provide a useful error
message.

## Document Thrown Exceptions (Item 74)

**Do not** add _unchecked_ exceptions to the `throws` clause of a method:

```java
public void disconnect() throws IllegalStateException {
}
```

**Do instead** only add _checked_ exceptions to the `throws` clause―and
document _both_ with the `@throws` tag in the JavaDoc.

/**
 * @throws IllegalStateException if the connection was already closed
 */
public void disconnect() {
}

## Failure-Capture Information (Item 75)

**Do not** force the caller to parse out crucial information out of the
exception message:

```java
try {
    operation.perform();
} catch (WhateverException ex) {
    if (ex.getMessage().contains("disconnected")) {
        db.connect();
    } else {
        // ...
    }
}
```

**Do instead** create your own exception class with dedicated fields for error
information, initialize those using the constructor upon occurrence and provide
accessor methods so that the caller can use them.

```java
// declaration:
public class NotCoveredPaymentException extends Exception {
    private final double balance;
    private final double amount;

    public NotCoveredPaymentException(double balance, double amount) {
        this.balance = balance;
        this.amount = amount;
    }

    public double getBalance() {
        return balance;
    }

    public double getAmount() {
        return amount;
    }
}

// usage:
if (account.getBalance() < invoice.getAmount()) {
    throw new NotCoveredPaymentException(account.getBalance(), invoice.getAmount());
}
```

However, make sure to _not_ serve any critical information such as passwords
and encryption keys.
