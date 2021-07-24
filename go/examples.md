# Examples

## Marshaling

Given this structure:

```go
type Employee struct {
	EmployeeID int
	Name       string
	Position   string
	Manager    *Employee
	Salary     float32
	Skills     []string
}
```

And these entries:

```go
boss := Employee{
    EmployeeID: 1,
    Name:       "Pointy Haired Boss",
    Position:   "Manager",
    Manager:    nil,
    Salary:     250000,
    Skills:     nil,
}

dilbert := Employee{
    EmployeeID: 42,
    Name:       "Dilbert",
    Position:   "Engineer",
    Manager:    &boss,
    Salary:     90000,
    Skills:     []string{"Programming", "Mechanical Engineering"},
}

wally := Employee{
    EmployeeID: 18,
    Name:       "Wally",
    Position:   "Engineer",
    Manager:    &boss,
    Salary:     120000,
    Skills:     []string{"Slacking Off", "Sleeping", "Avoiding Work"},
}
```

The values can be encoded as JSON, XML, ASN.1 and others.

### JSON

Output a struct variable as a JSON string:

```go
data, err := json.Marshal(boss)
if err == nil {
    fmt.Println(string(data))
}
```

Output:

    {"EmployeeID":1,"Name":"Pointy Haired Boss","Position":"Manager",
    "Manager":null,"Salary":250000,"Skills":null}

Output using indentation for better human readability:

```go
data, err := json.MarshalIndent(boss, "", "\t")
if err == nil {
    fmt.Println(string(data))
}
```

Output:

    {
        "EmployeeID": 1,
        "Name": "Pointy Haired Boss",
        "Position": "Manager",
        "Manager": null,
        "Salary": 250000,
        "Skills": null
    }

The JSON field names can be modified using field tags in the underlying struct:

```go
type Employee struct {
    EmployeeID int       `json:"id"`
    Name       string    `json:"name"`
    Position   string    `json:"position"`
    Manager    *Employee `json:"boss"`
    Salary     float32   `json:"wage"`
    Skills     []string  `json:"knowledge"`
}
```

Output (using the above marshaling code):

    {
        "id": 1,
        "name": "Pointy Haired Boss",
        "position": "Manager",
        "boss": null,
        "wage": 250000,
        "knowledge": null
    }

Fields with `nil` values can be suppressed for the output using the `omitempty`
field tag:

```go
Skills []string `json:"knowledge,omitempty"`
```

Output (using the above marshaling code):

    {
        "id": 1,
        "name": "Pointy Haired Boss",
        "position": "Manager",
        "boss": null,
        "wage": 250000,
        "knowledge": null
    }

A given JSON string can be unmarshaled into a struct variable:

```go
asokStr := `{
    "id": 101,
    "name": "Asok",
    "position": "intern",
    "boss": {
        "id": 1,
        "name": "Pointy Haired Boss",
        "position": "Manager",
        "boss": null,
        "wage": 250000,
        "knowledge": null
    },
    "wage": 30000,
    "knowledge": ["Learning by Doing", "Asking Questions"]
}`
data = []byte(asokStr)
var asok Employee
json.Unmarshal(data, &asok)
fmt.Printf("%#v\n", asok)
```

Output:

    main.Employee{EmployeeID:101, Name:"Asok", Position:"intern",
    Manager:(*main.Employee)(0xc00007e230), Salary:30000,
    Skills:[]string{"Learning by Doing", "Asking Questions"}}

## Templates

Given this data structure, example data and functions (`playground/payroll.go`):

```go
package payroll

import (
	"fmt"
	"time"
)

type Employee struct {
	Name         string
	Position     string
	YearlySalary int
}

var Employees = []Employee{
	{
		Name:         "Pointy Haired Boss",
		Position:     "Manager",
		YearlySalary: 250000,
	},
	{
		Name:         "Dilbert",
		Position:     "Engineer",
		YearlySalary: 120000,
	},
	{
		Name:         "Wally",
		Position:     "unknown",
		YearlySalary: 150000,
	},
	{
		Name:         "Asok",
		Position:     "Intern",
		YearlySalary: 24000,
	},
}

type Payday struct {
	Date      time.Time
	Employees []Employee
	Note      string
}

var August2018Payday = Payday{
	Date:      time.Date(2018, time.August, 25, 0, 0, 0, 0, time.Local),
	Employees: Employees,
	Note:      "Consider sacking Asok and giving Pointy Haired Boss a raise",
}

func FormatMonthDate(date time.Time) string {
	return date.Format("Jan/2006")
}

func FormatCurrency(amount int) string {
	return fmt.Sprintf("USD %6d", amount)
}

func YearlyToMonthly(amount int) string {
	return FormatCurrency(amount / 12)
}
```

Both plain text and HTML output can be generated using templates:

### Plain Text

`playground/payroll/cmd/text.go`:

```go
package main

import (
	"log"
	"os"
	"playground/payroll"
	"text/template"
)

const tmplt = `
Payroll (for {{.Date | formatMonthDate}})
======================
{{range .Employees}}
Name:	        {{.Name}}
Position:       {{.Position}}
Yearly Salary:  {{.YearlySalary | formatCurrency}}
Monthly Salary: {{.YearlySalary | yearlyToMonthly}}
{{end}}
Note: {{.Note}}
`

var monthlyPayroll = template.Must(template.New("payroll").
	Funcs(template.FuncMap{
		"formatMonthDate": payroll.FormatMonthDate,
		"formatCurrency":  payroll.FormatCurrency,
		"yearlyToMonthly": payroll.YearlyToMonthly,
	}).Parse(tmplt))

func main() {
	err := monthlyPayroll.Execute(os.Stdout, payroll.August2018Payday)
	if err != nil {
		log.Fatal(err)
	}
}
```

Output:

    Payroll (for Aug/2018)
    ======================

    Name:	        Pointy Haired Boss
    Position:       Manager
    Yearly Salary:  USD 250000
    Monthly Salary: USD  20833

    Name:	        Dilbert
    Position:       Engineer
    Yearly Salary:  USD 120000
    Monthly Salary: USD  10000

    Name:	        Wally
    Position:       unknown
    Yearly Salary:  USD 150000
    Monthly Salary: USD  12500

    Name:	        Asok
    Position:       Intern
    Yearly Salary:  USD  24000
    Monthly Salary: USD   2000

    Note: Consider sacking Asok and giving Pointy Haired Boss a raise

### HTML

`playground/payroll/cmd/html.go`:

```go
package main

import (
	"html/template"
	"log"
	"os"
	"playground/payroll"
)

const tmplt = `
<html>
	<head>
		<title>Payroll (for {{.Date | formatMonthDate}})</title>
		<style type="text/css">
			th {
				text-align: left;
			}
			th, td {
				padding: 5px;
			}
		</style>
	</head>
	<body>
		<h1>Payroll (for {{.Date | formatMonthDate}})</h1>
		<table>
			<tr>
				<th>Name</th>
				<th>Position</th>
				<th>Yearly Salary (USD)</th>
				<th>Monthly Salary (USD)</th>
			</tr>
			{{range .Employees}}
			<tr>
				<td>{{.Name}}</td>
				<td>{{.Position}}</td>
				<td align="right">{{.YearlySalary}}</td>
				<td align="right">{{.YearlySalary | yearlyToMonthly}}</td>
			</tr>
			{{end}}
			<p>Note: <em>{{.Note}}</em></p>
		</table>
	</body>
</html>
`

var monthlyPayroll = template.Must(template.New("payroll").
	Funcs(template.FuncMap{
		"formatMonthDate": payroll.FormatMonthDate,
		"yearlyToMonthly": func(amount int) int { return amount / 12 },
	}).Parse(tmplt))

func main() {
	err := monthlyPayroll.Execute(os.Stdout, payroll.August2018Payday)
	if err != nil {
		log.Fatal(err)
	}
}
```

Output:

```html
<html>
	<head>
		<title>Payroll (for Aug/2018)</title>
		<style type="text/css">
			th {
				text-align: left;
			}
			th, td {
				padding: 5px;
			}
		</style>
	</head>
	<body>
		<h1>Payroll (for Aug/2018)</h1>
		<table>
			<tr>
				<th>Name</th>
				<th>Position</th>
				<th>Yearly Salary (USD)</th>
				<th>Monthly Salary (USD)</th>
			</tr>
			
			<tr>
				<td>Pointy Haired Boss</td>
				<td>Manager</td>
				<td align="right">250000</td>
				<td align="right">20833</td>
			</tr>
			
			<tr>
				<td>Dilbert</td>
				<td>Engineer</td>
				<td align="right">120000</td>
				<td align="right">10000</td>
			</tr>
			
			<tr>
				<td>Wally</td>
				<td>unknown</td>
				<td align="right">150000</td>
				<td align="right">12500</td>
			</tr>
			
			<tr>
				<td>Asok</td>
				<td>Intern</td>
				<td align="right">24000</td>
				<td align="right">2000</td>
			</tr>
			
			<p>Note: <em>Consider sacking Asok and giving Pointy Haired Boss a raise</em></p>
		</table>
	</body>
</html>
```
