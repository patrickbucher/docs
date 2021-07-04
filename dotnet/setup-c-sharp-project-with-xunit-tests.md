# Setup C# Project with xUnit Tests

Install the .Net SDK and check the version:

    # pacman -S dotnet-sdk
    $ dotnet --version
    5.0.204

Create a new project called "grading":

    $ mkdir grading
    $ cd grading
    $ git init

    $ dotnet new sln
    $ dotnet new classlib -o Grading  # classlib or console
    $ dotnet sln add Grading/Grading.csproj
    $ mv Grading/Class1.cs Grading/Grading.cs

`Grading/Grading.cs`:

```cs
using System;

namespace Grading
{
    public class Grading
    {
        public static int Add(int a, int b)
        {
            return a + b;
        }
    }
}
```

    $ dotnet new xunit -o Grading.Tests
    $ dotnet sln add Grading.Tests/Grading.Tests.csproj
    $ mv Grading.Tests/UnitTest1.cs Grading.Tests/GradingTest.cs

Reference the productive code from the test code:

    $ dotnet add Grading.Tests/Grading.Tests.csproj reference Grading/Grading.csproj

`Grading.Tests/GradingTest.cs`:

```cs
using Xunit;
using Grading;

namespace Grading.Tests
{
    public class GradingTest
    {
        [Fact]
        public void TestAdd()
        {
            Assert.Equal(7, Grading.Add(3, 4));
        }
    }
}
```

Run the test:

    $ dotnet test
