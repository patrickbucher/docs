# How Software Is Built

## New Preface

Three fundamental abilities needed to not lag farther and farther behind
evolving computers:

1. observe and understand the significance of the observed
2. act congruently in difficoult interpersonal situations
3. understand complex situations; plan and modify the plan (the subject of this
   book)

## What Is Quality? Why Is It Important?

Adequate quality to one person may be inadequate quality to another.

> Quality is meeting _some person's_ requirements.

> Every statement about quality is a statement about some person(s).

> Who is the person behind that statement about quality.

Some ideas about software quality:

- zero defects (user)
- lots of features (some users, marketers)
- elegant code (developers)
- high performance (users, sales)
- low development cost (customer, managers)
- rapid development (users, marketers)
- user-friendliness (users—different kinds of)

> More quality for one person may mean less quality for another.

> Whose opinion of quality is to count when making decisions?

> Quality is value to some person.

Decisions are often hidden from the conscious minds of the persons who make
them. A quality manager must bring those decisions into consciousness.

Internal software organizations have little competition and therefore stagnate.

Improving quality is difficoult (up- or downward spiral):

1. motivation to measure the cost of quality -> 2.
2. understanding the value of quality -> 3.
3. motivation to achieve quality -> 4.
4. understanding of how to achieve quality -> 1.

A lock-on effect, e.g. caused by the choice of a programming language, causes
the cost of change to increase, the motivation and knowledge to change to
decrease over time. A lock-on effect for a programming language entails:

- software tools
- hardware systems (less common nowadays)
- people trained and hired
- specialized consultants
- user community
- managers that grew with it
- books, trainings
- philosophy of software engineering
- user interface philosophy

> People will always choose the familiar over the cofortable.

No two software organisations are 1) exactly alike or 2) entirely different.

There is some common software culture; it's properties can be found in the
entire world. Some characteristics cluster together as _patterns_. Organizations
lock in on one of those patterns due to conservatism manifested in:

1. satisfaction with current quality level
2. fear of losing that level when improvements fail
3. no understanding for other cultures
4. invisibility of their own culture

However, improving quality requires cultural change. Resistance can be overcome
by preserving the good that is already there.

## Software Subcultures

The critical factor to software quality is the people involved (their
motivations and reactions).

The "manufacturing" part in software is its duplication; a rather trivial task.
Ideas such as "Zero Defects" are only sensibly applied to the duplication part
of software. The parallel development of requirements software is the critical
part of software quality.

Most software development takes place in a "dirty" environment, where the
requirements cannot be assumed correct. An "economics of quality" (tradeoffs in
terms of correctnes?) only exist if there's a correct set of requirements.

The requirements process can destroy value, e.g. if it is figured out that the
wrong thing was built. Defective software, however, can also provide a lot of
value.

If the customers of a software organization are satisfied, there's no point in
changing the way that organization works. Mild dissatisfaction is better tackled
using small, gradual improvements rather than cultural change.

Trying to improve your way of of the wrong pattern using small steps is like
creating a more detailed map of the wrong trip.

> Quality is the ability to consistently get what people need. That means
> producing what people will value and not producing what people won't value.

Quality patterns should not be denoted in terms of "maturity", but in a more
neutral way. Any pattern can produce satisfying results. Maturity only works in
one way, but organizations can go back to a different pattern, too. Different
cultural patterns may be more or less _fitting_ to an organization and its
quality needs.

> Things are the  way they are because they got that way.

One can learn about processes by observing the products created by them.

Organizations can be classified by their _degree of congruence_ between what is
said and what is done in different parts of the organization:

- 0 Oblivious: "We don't even know that we're performing a process."
    - not a professional pattern, but useful as a baseline
    - most frequent source of new software
    - the software user is the organization that builds the software
    - no managers, no customers, no specified processes
    - no awareness of doing "software development"
    - produces satisfied users
- 1 Variable: "We do whatever we feel like at the moment."
    - awareness rises that pattern 0 doesn't suffice
    - separation from developer and user begins; blaming, too
    - management is not understood as part of development
    - "superprogrammer" (maybe leading a team) as source of success
    - myths about heroic deeds as company history
    - sometimes a pool of developers serve the specialist programmers
    - one or few rockstar programmers do the projects
    - procedures are abondoned at first sign of a crisis
    - improving quality by hiring a star
    - performance, schedule, and costs mostly depend on individual efforts, not
      teams
    - project results reinforce the belief system (projects succeed and fail
      depending on the programmer doing them)
- 2 Routine: "We follow our routines (except when we panic)."
    - when "leave the programmer" no longer yields satisfying results
    - "super manager" as the deciding factor (replaces the "super programmer")
    - procedures are put in place to keep programmers under control
    - procedures are followed, but their reason is not understood
    - works well until routines are bypassed in a "disaster" project (as if the
      procedures that were followed in successful projects aren't really trusted)
    - the lack of understanding the _why_ behind procedures, managers start
      issuing counterproductive orders (overtime, cut training, cutting corners)
    - silver bullets: refined measurements (in unstable environments),
      sophisticated (but not helpful) tools
    - "name magic": just say "agile" (or whatever) to work magic
- 3 Steering: "We choose among our routines by the results they produce."
    - managers are more skilled and experienced (not just promoted programmers
      with a lack of role-models that do "management by telling")
    - magic is replaced by understanding
    - procedures not completely defined, but understood; also followed in crisis
    - very few project failures; they always deliver (at least some) value
    - procedures are flexible, not rigid ("steering" instead of just following a
      plan)
    - programmers actually like to work in a well-managed (!) operation
    - tools are introduced later in the process, but used well
- 4 Anticipating: "We establish routines based on our past experience of them."
    - pattern 3 ("Steering") manager in the higher ranks of management
    - comprehensive process measurements and analysis initiated
- 5 Congruent: "Everyone is involved in improving everything all the time."
    - quality managers on highest level (CEO)
    - procedures are understood, followed, and improved all the time by everyone
      (continuous improvement)

Pattern 1 can look like pattern 3 from the outside: if there's no effective
management in place, management can't even cause much harm.

As long as everything goes well, pattern 2 can be mistaken for pattern 3. When
things get in trouble, the differences become obvious.

In practice, patterns 4 and 5 hardly exist.

## What Is Needed To Change Patterns?

The prevailing pattern is best detected by the way people think and communicate:

- Problems are handled by individuals in reactive ways (pattern 1).
- Tools and concepts are used, but in the wrong way (pattern 2; e.g. reasoning
  remains verbal, despite of using "statistics").
- Linear reasoning ("A caused B") and unjustifiable certainty in what is known
  prevailing (pattern 2).
- Problems are handled less emotionally; emergencies are handled better; people
  act more proactively (pattern 3).
- Measurement is used, but is sometimes meaningless (process not stable enough
  to gain useful data; pattern 3).
- Processes and measurements are stable; single managers can't force
  organizations into big mistagkes (pattern 4).
- Scientific reasoning; more problems prevented than handled (pattern 5).

In order to improve the quality of the organization, the quality of thinking
needs to be improved first.

Every pattern has its models (implicit or explicit) that guide the
organizations's thinking.

Sometimes there is not enough incentive to change patterns, so it makes sense to
remain with the old, sufficient one. However, this is only a concious decision
if the information about incentives and about other patterns is known.

A pattern change might cause more (temporary) costs in some department
(development) in order to save costs in another department (service). Such
change is only possible, if the organization supports this change on a higher
level.

The higher the demands posed by customers and the problems itself, the higher a
pattern is needed. There is also a tradeoff: lower demands by the customer
combined with higher demands of the problem itself could be satisfied with the
same pattern.

An organization can remain in a pattern for a long time if:

- customers are not demanding
- problems aren't getting more demanding
- there's no competition

Under those circumstances, an organization can even stagnate.

Resistance to change often stems from certain _thinking patterns_:

- circular argument
    - don't try because you might fail
    - we don't know if you'd fail, because you don't try
- classic software cycle
    - we do the best possible job; if others do their job better, their problem
      must be easier
    - consultants have bad development habits and therefore must be isolated
      from internal developers; so we don't know how they work
    - our rockstar is never at fault; if something fails, someone else is to
      blame; so the rockstar's weaknesses are never found
    - our rockstar knows most about software; if alternatives are to be
      investigated, ask our rockstar; so we'll never use something the rockstar
      doesn't understand

Those _closed circuits_ can be opened by asking if your rate of success is high
enough. Over time, evidence to the contrary might accumulate. Unfortunately,
patterns 0, 1, and 2, which need change the most, often don't keep records of
their failures and their cost.

Cultural patterns can be broke by starting the information flowing:

- technical reviews offer insight into the products
- send people to seminars to discover what other people do
- ask upper management:
    - how do you spot failures/poor quality?
    - apply this definition to individual cases

Patterns 0, 1, and 2 are based on a lack of trust:

- pattern 0: we only trust ourselves
- pattern 1: we don't trust managers
- pattern 2: we don't trust programmers

Higher patterns are not "more mature", but "more open":

- pattern 0: as open as the individual
- pattern 1: open to information exchange between developer and user
- pattern 2: open to information exchange between developer, user, and manager
- pattern 3: open in all directions to information about the product
- pattern 4: " about the process
- pattern 5: " about the culture

Creating trustworty sub-systems reduces the amount of communication needed
("checking up") and is needed to open up.

Trust reduces the need for data; increasing data flows might indicate trouble.

If in trouble, there's no time to learn better ways how to develop software
(vicious cycle).

- past success creates inertia; a past strenght become a weakness
    - lots of code: a lot of value, a lot to maintain
    - past practices: were successful, no need to improve seen
    - people's attitudes: worked then, why change?

Any culture must accomplish these tasks:

1. present: keep performing today; don't slip backwards
2. past: maintain the foundation from yesterday; don't forget what you know
3. future: build the next pattern to guide the change process

To move to a higher pattern, things have to be learned:

- 0 to 1: humility (exposure to what others are doing)
- 1 to 2: ability (technical training and experience)
- 2 to 3: stability (quality software management)
- 3 to 4: agility (tools and techniques)
- 4 to 5: adaptability (human development)

Lockons are strong forces that prevent change (driving on one particular side of
the rode in England vs. Germany).

## Control Patterns for Management

Organizations can remain at pattern 1 or 2, because their problems do not
require them to be elsewhere. However, higher demands require different
patterns, otherwise they experience the grief cycle:

1. denial: control the pain by controlling the information (don't notice)
2. blaming others
3. tradeoffs
4. realizing that changes are needed

Quality standards and productivity are moving targets: demands are getting
higher all the time. When shooting at moving targets, instruction only helps if
it is general enough (shooting at moving targets in general, not at a specific
moving target in particular).

Moving targets are most likely being hit by firing many bullets (aggregation).
In a big market, many solution bullets are fired at single problems. Within an
organization, developing multiple programs to tackle very critical problems can
be useful, for the redundancy provides means for comparison.

Pattern 2 organizations often unknowingly perform serial aggregation. A failed
project is tried again later.

Pattern 1 organization often produce a lot of redundant tooling, because
programmers are not aware of colleagues facing the same issues.

In pattern 2, measures to "improve efficiency" often work against aggregation by
the means of centralization.

Evaluating different alternatives before bying a software is also aggregation.
This process is often seen in pattern 3.

Aggregating is like shooting with a shotgun; feedback control is like shooting
with a rifle. Cybernetics is the "science of aiming". In pattern 1, a cybernetic
model starts with the idea of a system to be controlled:

- inputs
    - resources
    - requirements
    - randomness
- outputs
    - software
    - other outputs
        - competence
        - tools developed
        - stronger/weaker teams
        - etc.

The system's behaviour is governed by the formula:

> Behaviour depends on both state and input.

Thus, the control also depends on what's going on internally (state).

The model of pattern 1 organizations says:

a. tell us what you want (don't change your mind)
b. give us some resources (whenever we ask)
c. don't bother us (eliminate randomness)

For pattern 0, there's no point a.

In pattern 2, aggregation is done by adding more resources to the system, which
is tightly controlled. The internal state of the development systemd won't be
affected by the controller's efforts, only the inputs:

- make them smarter by training, tooling, hiring
- motivate them with cash, more interesting assignments

In pattern 3, the controller can measure performance. Inputs and state must be
connected for feedback control by comparing the desired state to the actual
state.

Pattern 2 erroneously equate "controller" with "manager". The first law of bad
management:

> When something isn't working, do more of it.

Managers _are_ controllers, but so is everybody involved in the project.

In pattern 3, management is mostly feedback control:

- plan what should happen
- observe what is happening
- compare planned with observed
- take actions to bring the observed closer to the planned

When pattern 2 organizations try to move to pattern 3, they start to make
observations, but don't know which ones are useful (false focus on quantity; no
means of measuring quality).

Measuring data (e.g. by doing reviews) doesn't help unless the controller
propertly acts upon the findings.

Without information, nothing can be controlled for very long. A process must be
stable and yield visual evidence of progress, which is rarely the case in
pattern 2.

Quality software development not only needs "computer science" or "cybernetics",
byt also an _engineering discipline_:

> the application of scientific principles to practical ends as the design,
> construction, and operation of efficient and economical structures, equipment,
> and systems.

- An organization has the pattern in which it turns out products _consistently_.
- Emphasize what the organization is doing well to inforce that instead of
  confronting the organization with its "sins" all the time.
- Control means, that some error level can be held in check, not that there are
  no errors.
- Pattern 3 looks like pattern 2 from the outside if there are no errors to be
  handled.
- Action is the result of comparing the observed with the planned.
- Aggregation sometimes yields better returns than feedback control for certain
  situations (e.g. handling of emergency cases).
- Pattern 4 uses feedback control to not only to improve the product, but also
  the process.
- Pattern 5 applies feedback control to the entire organization.

## Making Explicit Management Models

A controller must not only have accurate and timely observations, but also
understand those observations ("system models"). One must know: 1) what is
important to observe, and 2) what is the right response to an observation.

I pattern 1 and 2, those system models are implicit, e.g. "more pressure =
faster work" or "bugs occur at random", and therefore hard to discuss, test and
improve; the organization is stuck in its current pattern, and therefore hard to
discuss, test and improve; the organization is stuck in its current pattern.

A lack of calendar time is not necessarily the cause for a project to fail, but
the reason why other failures are being detected. Fred Brooks rephrased:

> Lack of calendar time has forced more failing software projects to face the
> _reality of their failure_ than all other reasons combined.

Or:

> Lack of calendar time has forced more failing software projects to face the
> _incorrectness of their models_ than all other reasons combined.

Brooks' failure dynamics (and faulty system model):

- poor estimation techniques (depends on a model, such as "all will go well")
- confuse effort with progress (effort and progress often correlated, but not
  always; no correlation in other cases, e.g. lines of code and progress)
- managers lack effectiveness to be "courteously stubborn" (lack of a model to
  be stubborn about)
- poor monitoring of schedule progress (drawing _some_ models from other
  engineering disciplines could help)
- adding manpower to late projects (again: false correlation)

> More software projects have gone awry for lack of quality, which is part of
> many destructive dynamics, than for all other causes combined.

> More software projects have gone awry from management taking action based on
> incorrect systemd models than for all other causes combined.

The problem is not only one particular dynamic, but misunderstanding the model
behind the dynamic.

Software managers often choose a linear model when non-linear forces are at
work. They try to use patterns that worked for small systems also for big
systems, which have different dynamics (_scaling fallacy_). This is common for
pattern 2 managers and usually leads them into software crises.

Two programmers performing one unit of work won't simply produce two units when
working together, for their interaction produces non-linearities:

    1 + 1 = 2 + stimulation gain - interference loss

Adding people to a late project increses the total work to be done:

- old workers need to train new workers
- more coordination is required
- people in the project might work _against_ one another

Scaling Fallacy: "Large systems are like small systems, just bigger." (Wrong!)

Written and spoken language is linear, therefore we often fall for linear
models. Two-dimensional _diagrams of effects_ are a better fit for non-linear
interdependencies:

- nodes: measurable quantities ("cloud" symbols for conceptual/actual
  measurements)
- arrow from node A to node B: quantity A has an effect on quantity B
    - dot on the arrow: A moves in one direction, B moves in _another_ direction
    - no dot: A and B move in the _same_ direction
- start with quantities of interest (outputs), e.g.:
    - number of bugs
    - time spent to deal with bugs
    - number of bugs caused by fixing other bugs
- work back to possible causes using brainstorming
    - too little developer training
    - too little testing done
    - too much pressure to finish new feature fast
- connect causes and effects with arrows (with/without dots to indicate reverse
  effects)
- chart secondary effects
    - more bugs -> more time spent fixing bugs -> less time testing new features -> more bugs
    - more bugs -> less time for training -> worse quality in new code -> more bugs
- reading the diagram from cause to effect:
    - even number of dots on the path: inverse effects that cancel out one another
    - odd number: effects reinforce one another
- connecting a quantity to an arrow indicates a multiplicative effect

The purpose of these models is not rigorous numerical analysis, but stimulating
thinking. The important part is not the resulting diagram, but the process of
_diagramming_.

As long as the numbers are small, linear effects can be assumed, because small
deltas also produce small effects. As soon as non-linear effects are
measured—and an exponential relationship is detected—the system might already be
in deep trouble.

## Feedback Effects

Some actions can't be reversed, not even with help from higher management.

The Humpty Dumpty Syndrome:

1. manager becomes aware of a big risk
2. manager talks about the risk with higher management
3. higher management sees the risk as unlikely, doesn't react immediately, but
   promises lots of resources in case of emergency
4. manager convinces himself that everything is fine
5. the problem gets worse in a non-linear way; management throws resources at
   the problem, the problem gets worse anyway, and the manager is used as a
   scapegoat

The manager is not _courteously stubborn_ but skilled at not facing reality (Brooks).

Previous actions _can't always_ be revoked. Two Fallacies:

1. Reversible Fallacy: "What is done can always be undone."
    - firing half the staff
    - hire them back the next day
2. Causation Fallacy: "Every effect has a cause—and we can tell which is which."
    - causality is not a one-way street
    - feedback cycles reinforce themselves

Feedback cycles are self-reinforcing, making it hard to distinguish cause from
effect:

1. more bugs -> more fixes -> even more bugs
2. too little time to test -> more bugs -> more bugfixing -> even less time to test
3. low quality -> more frustration -> less motivation -> even worse quality

In a feedback cycle, cause and effect can look the same.

Systems with positive feedback loops either explode or collapse, depending on
the naming of the variable (measuring "quality" vs. "defects"; quality
collapses, defects explode).

Explosion and collapse change a system until the current model of the system no
longer applies. (Too many bugs: system is abandoned or bugs aren't tracked any
longer.)

Managers are often too optimistic that everything goes well or things will get
better by themselves. Pattern 2 managers don't know how to reason or communicate
about problems, slip into Humpty Dumpty Syndrome, and delay action even further.
Becoming aware that the problem got too big, they apply corrections that are too
big, starting an evern worse feedback cycle. (Adding more people to the project;
forcing them to work overtime; cutting technical reviews to save time, etc.)

Non-linearities are introduced in at least three different ways:

1. feeding back changes that _contribute to the workload_
    - more testing
    - more bugfixing
2. feeding back changes that _diminish the workforce_
    - more meetings
    - more training of workforce added
3. waiting too long, so that only big changes can have an effect, which creates
   other non-linear effects
    - switching technology
    - re-organizing the team
    - firing/hiring people

A system with positive feedback loop can only be stabilized by introducing an
adverse negative feedback loop. Management action that doesn't introduce this
correcting loop is cosmetic and only will delay the disaster, e.g. overtime work
for testing and fixing bugs. (Overtime work will in fact create more positive
feedback loops contributing to the problem.) Proper solutions must introduce a
negative feedback loop, such as properly conducting technical reviews, which
will both diminish the number of bugs and the time spent fixing bugs.

A controller can only be effective when he's connected by _two_ feedback loops
to the system, and if at least one of those loops is negative.

- reacting to schedule slippage by reducing requirements
- reacting to more bugs by conducting technical reviews
- reacting to illness by reducing overtime
- reacting to poor customer acceptance by design training

In pattern 3, the controller is connected to the system by two feedback loops:

1. through resources
2. through requirements

Action is only effective when taken early. To act small, one needs to sharpen
his the powers of observation.

A negative feedback loop is _not_ desirable, because stability is _not always_
desirable (e.g. when changing the pattern of an organization). Here, positive
feedback loops have to be established.

## Steering Software

In pattern 2, a plan is the sum of its steps:

> It's possible to make a project plan and follow it exactly.

In pattern 3, a plan gives orientation on where a projects stands:

> Plans are rough guides. We need steering to stay on course.

In order to steer a project, not only meaningful measurements based on accurate
effect models are needed, but also models on how interventions will affect the
system under control. (If plans always could be followed strictly, interventions
would be futile.)

Unlike pattern 1, pattern 2 works with plans, often wrapped into methologies
(i.e. the Waterfall Model), which describe an ideal series of steps.

In classic Waterfall, there's no going back:

1. Requirements
2. Analysis
3. Design
4. Coding
5. Testing
6. Operations

Modified Waterfall models have the notion of returning to an earlier stage
(rather GOTOs than proper iterations):

- requirements and analysis re-considered after design
- design and coding re-considered after testing

This unplanned re-considerations make estimation harder, which can cause
schedule overruns.

Sequential methods are like turn-by-turn directions that don't consider
real-time circumstances (traffic jams, road works) or mistakes (taking the wrong
turn, taking it too late). Sequential methods are based on an _ideal set of
instructions_. It is also assumed, that mistakes can be corrected without
intervention.

Small mistakes can be corrected by individuals. However, bigger projects hold
more potential for bigger mistakes that cannot be corrected without
interventions.

When sticking to a sequential plans, small detours are never tried; the
territory around the chosen route is never explored. However, there might be
better ways.

Organizations tend to rely on past experience of successful projects. As new
tools and methods are introduced, the relevance of past experiences and the
intuitive understanding of feedback effects can be undermined.

A more iterative Waterfall only has some specific places for feedback at the end
of a phase. However, waiting for such a phase to end ("design", "coding") bears
risks:

- Not collecting feedback during a phase makes it impossible to detect  problems
  early on.
- Re-iterating a phase after a problem has been detected causes major
  disturbances in the whole process, say, doing a re-design after coding has
  been "finished". Such "big" steps back are rather avoided than undertaken; the
  organization might go on with a flawed intermediate product to the next phase.

This methodology can be summarized as "doing it completely right or doing it
over". There's no notion of small deviations and according corrections.

Instead of one global process (Waterfall), a project can be split up in smaller
task cells that provide their own feedback loop (e.g. a User Story).

> Good intervention models will help us to understand what we can't control, but
> a faulty model may lead us to overlook a number of effective interventions.

In Waterfall, it is assumed that every phase brings the project closer to the
desired state. However, in any phase there might happen things that bring the
project in a worse state:

- errors are introduced in the design and code
- project members get falsely confident
- project members burn out, quit
- conflicts between project members emerge; the no longer want to work together

Such model don't account for "soft" factors, such as employees getting
frustrated or sick.

Errors introduced in the coding phase could originate in any of the (earlier)
phases (wrong requirements, erroneous analysis, bad design, bad coding).
However, they don't manifest themselves before testing. Likewise, frustration
and tension might rise during the whole project, but the conflicts might only
erupt towards the (planned) end of the project.

Methodologies are often only product focused and don't account for other outputs
("soft" factors).

Pattern 2 managers often would rather hide in their offices and work with plans
rather than with human beings. The role of human action in project management is
often denied. However, human decision points are the places where a crisis can
be prevented.

> More software projects have gone awry _because their managers didn't know how
> to respond to lack of calender time_ than for all other causes combined.

Loops that concern management contain decisions by people:

> Whenever there's a human decision point in the system, it's not the event that
> determines the next event, but someone's _reaction_ to that event.

There are two types of laws concerning software engineering management:

1. "natural" laws (accept them)
2. "human decision laws" (learn to control them)

People often mistake human decision laws for natural laws:

- "We were late with coding, _therefore_ we had less time to test the
  application."
    - _therefore_ suggests that a natural (or logic) law was followed
    - doing less testing was actually a human decision
- "We could not finish a proper design, but we _had to_ start coding, _because_
  time for design was up."
    - _because_ suggests that one should start implementing an unfinished design
      when the clock tells you so
    - continuing with an unfinished design was a human decision

Pay attention to words that suggest a logical succession of events, such as "had
to", "because", "therefore", and ask for the _reasoning behind_ it. Record
instances of human reasoning disguised as laws of nature.

## Failing to Steer

In pattern 2, managers only plan what should happen. In pattern 3, they should
also: observe, compare the observed to the planned, and take actions to move the
observed closer to the planned.

There are three dynamics standing in their way:

1. Victim Mentality
    - When bad things happen, managers fail to see their points of action.
      However, what counts are not only those events, but also (and foremost)
      the reactions to those events. "Victim language" can be reframed as
      "Controller language".
    - Brooks' Law (adding people to a late projects makes it later) can be
      mitigated: As long as the added staff doesn't interfere with the existing
      staff's process, they still can add value (checking and improving
      documentation, reviewing code, creating test cases, do chores for others
      in the project group).
2. Suppressing "Negative Talk"
    - If employees are punished for negative reports, they're incentivized to
      produce rosy looking fake reports:
        - quick and dirty fixes to problems so that they don't have to be
          reported
        - classify problems with lowered severity
        - grouping multiple problems together so that it looks like there are
          fewer problems
        - blaming users and the environment
        - interpret problems in a beneficial way
    - Inaccurate reports lead to improper actions: like navigating with the
      wrong man and the wrong coordinates.
    - Employees should be rewarded for handing in accurate reports instead.
3. Using Wrong Intervention Models
    - By acting on the wrong intervention model, problems are made worse.
    - Example: A software project conducted using an iterative approach is
      behind schedule. He decides to sacrifice quality to make up for the time
      lost. As more defects occur, the manager reacts by putting "recovery
      functions" into the product in order to make up for the defects. The
      software project falls even more behind schedule, and quality detoriates
      even further, which requires more "recovery functions". The customer, who
      has to wait longer, wants to be rewarded for his patience—by asking for
      more features. This creates a vicious cycle.
    - The control points are working backwards: every intervention makes the
      problems worse. In this case, the interventions just need to be reversed.
      In the above example, a trust period is introduced, so that the developers
      can catch up and improve the product's quality.
    - Two parties blaming each other creates a mutually destructive feedback
      loop. This can be solved with a better understanding of the system—unless
      the two parties have gotton too far from each other and prefer revenge
      over reconciliation.
    - Tools do not determine how they are being used. They can be applied for
      the worse or for the better.