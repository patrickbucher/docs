---
title: 'Gerald M. Weinberg: “How Software Is Built”'
subtile: 'Book Summary'
author: 'Patrick Bucher'
---

_This is a rough summary of “How Software Is Built”, Volume 1/6 of the “Quality
Software Management” by Gerald M. Weinberg. Remarks that are not found in the
book are written within [square brackets]._

There are three fundamental abilities needed to not lag farther and farther
behind ever evolving computers:

1. Observing, and understanding the significance of the observed.
2. Acting congruently in difficoult interpersonal situations.
3. Understanding complex situations; planning and modifying the plan.

The third point is the subject of this book.

# What Is Quality? Why Is It Important?

Adequate quality to one person may be inadequate quality to another:

> Quality is meeting _some person’s_ requirements.
> Every statement about quality is a statement about some person(s).
> Who is the person behind that statement about quality.

There are different ideas about software quality, some of them (and their
source) are:

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

Decisions are often hidden from the conscious minds of the persons who makes
them. A quality manager must bring those decisions into consciousness.

Internal software organizations have little competition and therefore tend to
stagnate.

Improving quality is difficult, there is an up- or downward spiral:

1. motivation to measure the cost of quality (influencing point 2)
2. understanding the value of quality (influencing point 3)
3. motivation to achieve quality (influencing point 4)
4. understanding of how to achieve quality (influencing point 1)

A lock-on effect, e.g. caused by the choice of a programming language, causes
the cost of change to _increase_, but the motivation and knowledge to change to
_decrease_ over time. A lock-on effect for a programming language entails:

- software tools
- hardware systems [less common nowadays]
- people trained and hired
- specialized consultants
- user community
- managers that grew with it
- books, trainings
- philosophy of software engineering
- user interface philosophy

> People will always choose the familiar over the cofortable.

No two software organizations are 1) exactly alike or 2) entirely different.

There is some common software culture; its properties can be found in the entire
world. Some characteristics cluster together as _patterns_. Organizations lock
in on one of those patterns due to conservatism manifested in:

1. satisfaction with current quality level
2. fear of losing that level when improvements fail
3. no understanding for other cultures
4. invisibility of their own culture

However, improving quality requires cultural change. Resistance can be overcome
by preserving the good that is already there.

# Software Subcultures

The critical factor to software quality is the people involved: their
motivations and reactions.

The “manufacturing” part in software is its duplication; a rather trivial task.
Ideas such as “Zero Defects” are only sensibly applied to the duplication part
of software. The parallel development of requirements software is the critical
part of software quality.

Most software development takes place in a “dirty” environment, where the
requirements cannot be assumed correct. An “economics of quality” (tradeoffs in
terms of correctnes) only exist if there’s a correct set of requirements.

The requirements process can destroy value, e.g. if it is figured out that the
wrong thing was built. Defective software, however, can also provide a lot of
value.

If the customers of a software organization are satisfied, there’s no point in
changing the way that organization works. Mild dissatisfaction is better tackled
using small, gradual improvements rather than cultural change. However, trying
to improve your way out of the wrong pattern using small steps is like creating
a more detailed map of the wrong trip.

> Quality is the ability to consistently get what people need. That means
> producing what people will value and not producing what people won’t value.

Quality patterns should not be denoted in terms of “maturity”, but in a more
neutral way. Any pattern can produce satisfying results. Maturity only works in
one way, but organizations can go back to a different pattern, too. Different
cultural patterns may be more or less _fitting_ to an organization and its
quality needs.

> Things are the way they are because they got that way.

One can learn about processes by observing the products created by them.

Organizations can be classified by their _degree of congruence_ between what is
said and what is done in different parts of the organization. Those patterns are:

- 0 _Oblivious_: “We don’t even know that we’re performing a process.”
    - not a professional pattern, but useful as a baseline
    - most frequent source of new software
    - the software user is the organization that builds the software
    - no managers, no customers, no specified processes
    - no awareness of doing “software development”
    - produces satisfied users nonetheless
- 1 _Variable_: “We do whatever we feel like at the moment.”
    - awareness rises that pattern 0 doesn’t suffice
    - separation from developer and user begins; blaming, too
    - management is not understood as part of development
    - “superprogrammer” (maybe leading a team) as source of success
    - myths about heroic deeds as company history
    - sometimes a pool of developers serve the specialist programmers
    - one or few rockstar programmers do the projects
    - procedures are abondoned at first sign of a crisis
    - improving quality by hiring a star
    - performance, schedule, and costs mostly depend on individual efforts, not
      on teams
    - project results reinforce the belief system (projects succeed and fail
      depending on the individual programmers doing them)
- 2 _Routine_: “We follow our routines (except when we panic).”
    - when “leave the programmer” no longer yields satisfying results
    - “super manager” as the deciding factor (replaces the “super programmer“)
    - procedures are put in place to keep programmers under control
    - procedures are followed, but their reasons are not understood
    - works well until routines are bypassed in a “disaster” project (as if the
      procedures that were followed in successful projects aren’t really trusted)
    - lack of understanding the _why_ behind procedures, managers start issuing
      counterproductive orders (overtime, less training, cutting corners)
    - silver bullets: refined measurements (in unstable environments),
      sophisticated (but not helpful) tools
    - “name magic”: just say “structured programming” [or “agile”] to work magic
- 3 _Steering_: “We choose among our routines by the results they produce.”
    - managers are more skilled and experienced (not just promoted programmers
      with a lack of role-models that do “management by telling“)
    - magic is replaced by understanding
    - procedures not completely defined, but understood; also followed in crisis
    - very few project failures; they always deliver _at least some_ value
    - procedures are flexible, not rigid (“steering” instead of just following a
      plan)
    - programmers actually like to work in a well-managed (!) operation
    - tools are introduced later in the process, but used well
- 4 _Anticipating_: “We establish routines based on our past experience of
  them.”
    - pattern 3 (“Steering”) manager in the higher ranks of management
    - comprehensive process measurements and analysis initiated
- 5 _Congruent_: “Everyone is involved in improving everything all the time.”
    - quality managers on highest level (CEO)
    - procedures are understood, followed, and improved all the time by everyone
      (continuous improvement)

Pattern 1 can look like pattern 3 from the outside: if there’s no effective
management in place, management can’t even cause much harm.

As long as everything goes well, pattern 2 can be mistaken for pattern 3. When
things get in trouble, the differences become obvious.

In practice, patterns 4 and 5 hardly exist.

# What Is Needed To Change Patterns?

The prevailing pattern is best detected by the way people think and communicate:

- Problems are handled by individuals in reactive ways (pattern 1).
- Tools and concepts are used, but in the wrong way (pattern 2; e.g. reasoning
  remains verbal, despite of using “statistics”).
- Linear reasoning (“A caused B”) and unjustifiable certainty in what is known
  prevailing (pattern 2).
- Problems are handled less emotionally; emergencies are handled better; people
  act more proactively (pattern 3).
- Measurement is used, but is sometimes meaningless (process not stable enough
  to gain useful data; pattern 3).
- Processes and measurements are stable; single managers can’t force
  organizations into big mistagkes (pattern 4).
- Scientific reasoning; more problems prevented than handled (pattern 5).

In order to improve the quality of the organization, the quality of thinking
needs to be improved first.

Every pattern has its models (implicit or explicit) that guide the
organizations’s thinking.

Sometimes there is not enough incentive to change patterns, so it makes sense to
remain with the old, sufficient one. However, this is only a concious decision
if the information about incentives and about other patterns is known.

A pattern change might cause more (temporary) costs in some department
(development) in order to save costs in another department (service). Such
change is only possible if the organization supports this change on a higher
level.

The higher the demands posed by customers and the problems itself, the higher a
pattern is needed. There is also a tradeoff: lower demands by the customer
combined with higher demands of the problem itself could be satisfied with the
same pattern.

An organization can remain in a pattern for a long time if:

- customers are not demanding
- problems aren’t getting more demanding
- there’s no competition

Under those circumstances, an organization can even stagnate.

Resistance to change often stems from certain _thinking patterns_:

- circular argument
    - don’t try because you might fail
    - we don’t know if you’d fail, because you don’t try
- classic software cycle
    - we do the best possible job; if others do their job better, their problem
      must be easier
    - consultants have bad development habits and therefore must be isolated
      from internal developers; so we don’t know how they work
    - our rockstar developer is never at fault; if something fails, someone else
      is to blame; so the rockstar’s weaknesses are never found
    - our rockstar developer knows most about software; if alternatives are to
      be investigated, ask our rockstar; so we’ll never use something the
      rockstar doesn’t understand

Those _closed circuits_ can be opened by asking if your rate of success is high
enough. Over time, evidence to the contrary might accumulate. Unfortunately,
patterns 0, 1, and 2, which need change the most, often don’t keep records of
their failures and their cost.

Cultural patterns can be broken by starting the information flowing:

- technical reviews offer insight into the products
- send people to seminars to discover what other people do
- ask upper management:
    - how do you spot failures/poor quality?
    - apply this definition to individual cases

Patterns 0, 1, and 2 are based on a lack of trust:

- pattern 0: we only trust ourselves
- pattern 1: we don’t trust managers
- pattern 2: we don’t trust programmers

Higher patterns are not “more mature”, but “more open”:

- pattern 0: as open as the individual
- pattern 1: open to information exchange between developer and user
- pattern 2: open to information exchange between developer, user, and manager
- pattern 3: open in all directions to information about the product
- pattern 4: open in all directions about the process
- pattern 5: open in all directions about the culture

Creating trustworty sub-systems reduces the amount of communication needed
(“checking up”) and is needed to open up. Trust reduces the need for data;
increasing data flows might indicate trouble. If in trouble, there’s no time to
learn better ways how to develop software (vicious cycle). Past successes create
inertia; a past strenght become a weakness:

- lots of code: a lot of value, a lot to maintain
- past practices: were successful, no need to improve them is seen
- people’s attitudes: worked then, why change?

Any culture must accomplish these tasks:

1. present: keep performing today; don’t slip backwards
2. past: maintain the foundation from yesterday; don’t forget what you know
3. future: build the next pattern to guide the change process

To move to a higher pattern, the following things have to be learned:

- 0 to 1: humility (exposure to what others are doing)
- 1 to 2: ability (technical training and experience)
- 2 to 3: stability (quality software management)
- 3 to 4: agility (tools and techniques)
- 4 to 5: adaptability (human development)

Lockons are strong forces that prevent change (e.g. driving on one particular
side of the road in England vs. Germany).

# Control Patterns for Management

Organizations can remain at pattern 1 or 2, because their problems do not
require them to be elsewhere. However, higher demands require different
patterns, otherwise they experience the grief cycle:

1. denial: control the pain by controlling the information (don’t notice)
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

In pattern 2, measures to “improve efficiency” often work against aggregation by
the means of centralization.

Evaluating different alternatives before bying a software is also aggregation.
This process is often seen in pattern 3.

Aggregating is like shooting with a shotgun; feedback control is like shooting
with a rifle. Cybernetics is the “science of aiming“. In pattern 1, a cybernetic
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

The system’s behaviour is governed by the formula:

> Behaviour depends on both state and input.

Thus, the control also depends on what’s going on internally (state).

The model of pattern 1 organizations says:

a. tell us what you want (don’t change your mind)
b. give us some resources (whenever we ask)
c. don’t bother us (eliminate randomness)

For pattern 0, there’s no point a.

In pattern 2, aggregation is done by adding more resources to the system, which
is tightly controlled. The internal state of the development systemd won’t be
affected by the controller’s efforts, only the inputs:

- make them smarter by training, tooling, hiring
- motivate them with cash, more interesting assignments

In pattern 3, the controller can measure performance. Inputs and state must be
connected for feedback control by comparing the desired state to the actual
state.

Pattern 2 erroneously equate “controller” with “manager“. The first law of bad
management:

> When something isn’t working, do more of it.

Managers _are_ controllers, but so is everybody involved in the project.

In pattern 3, management is mostly feedback control:

- plan what should happen
- observe what is happening
- compare planned with observed
- take actions to bring the observed closer to the planned

When pattern 2 organizations try to move to pattern 3, they start to make
observations, but don’t know which ones are useful (false focus on quantity; no
means of measuring quality).

Measuring data (e.g. by doing reviews) doesn’t help unless the controller
propertly acts upon the findings.

Without information, nothing can be controlled for very long. A process must be
stable and yield visual evidence of progress, which is rarely the case in
pattern 2.

Quality software development not only needs “computer science” or “cybernetics“,
byt also an _engineering discipline_:

> the application of scientific principles to practical ends as the design,
> construction, and operation of efficient and economical structures, equipment,
> and systems.

- An organization has the pattern in which it turns out products _consistently_.
- Emphasize what the organization is doing well to inforce that instead of
  confronting the organization with its “sins” all the time.
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

# Making Explicit Management Models

A controller must not only have accurate and timely observations, but also
understand those observations (“system models“). One must know: 1) what is
important to observe, and 2) what is the right response to an observation.

I pattern 1 and 2, those system models are implicit, e.g. “more pressure =
faster work” or “bugs occur at random“, and therefore hard to discuss, test and
improve; the organization is stuck in its current pattern, and therefore hard to
discuss, test and improve; the organization is stuck in its current pattern.

A lack of calendar time is not necessarily the cause for a project to fail, but
the reason why other failures are being detected. Fred Brooks rephrased:

> Lack of calendar time has forced more failing software projects to face the
> _reality of their failure_ than all other reasons combined.

Or:

> Lack of calendar time has forced more failing software projects to face the
> _incorrectness of their models_ than all other reasons combined.

Brooks’ failure dynamics (and faulty system model):

- poor estimation techniques (depends on a model, such as “all will go well“)
- confuse effort with progress (effort and progress often correlated, but not
  always; no correlation in other cases, e.g. lines of code and progress)
- managers lack effectiveness to be “courteously stubborn” (lack of a model to
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

Two programmers performing one unit of work won’t simply produce two units when
working together, for their interaction produces non-linearities:

    1 + 1 = 2 + stimulation gain - interference loss

Adding people to a late project increses the total work to be done:

- old workers need to train new workers
- more coordination is required
- people in the project might work _against_ one another

Scaling Fallacy: “Large systems are like small systems, just bigger.” (Wrong!)

Written and spoken language is linear, therefore we often fall for linear
models. Two-dimensional _diagrams of effects_ are a better fit for non-linear
interdependencies:

- nodes: measurable quantities (“cloud” symbols for conceptual/actual
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

# Feedback Effects

Some actions can’t be reversed, not even with help from higher management.

The Humpty Dumpty Syndrome:

1. manager becomes aware of a big risk
2. manager talks about the risk with higher management
3. higher management sees the risk as unlikely, doesn’t react immediately, but
   promises lots of resources in case of emergency
4. manager convinces himself that everything is fine
5. the problem gets worse in a non-linear way; management throws resources at
   the problem, the problem gets worse anyway, and the manager is used as a
   scapegoat

The manager is not _courteously stubborn_ but skilled at not facing reality (Brooks).

Previous actions _can’t always_ be revoked. Two Fallacies:

1. Reversible Fallacy: “What is done can always be undone.”
    - firing half the staff
    - hire them back the next day
2. Causation Fallacy: “Every effect has a cause—and we can tell which is which.”
    - causality is not a one-way street
    - feedback cycles reinforce themselves

Feedback cycles are self-reinforcing, making it hard to distinguish cause from
effect:

1. more bugs -> more fixes -> even more bugs
2. too little time to test -> more bugs -> more bugfixing -> even less time to test
3. low quality -> more frustration -> less motivation -> even worse quality

In a feedback cycle, cause and effect can look the same.

Systems with positive feedback loops either explode or collapse, depending on
the naming of the variable (measuring “quality” vs. “defects“; quality
collapses, defects explode).

Explosion and collapse change a system until the current model of the system no
longer applies. (Too many bugs: system is abandoned or bugs aren’t tracked any
longer.)

Managers are often too optimistic that everything goes well or things will get
better by themselves. Pattern 2 managers don’t know how to reason or communicate
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
adverse negative feedback loop. Management action that doesn’t introduce this
correcting loop is cosmetic and only will delay the disaster, e.g. overtime work
for testing and fixing bugs. (Overtime work will in fact create more positive
feedback loops contributing to the problem.) Proper solutions must introduce a
negative feedback loop, such as properly conducting technical reviews, which
will both diminish the number of bugs and the time spent fixing bugs.

A controller can only be effective when he’s connected by _two_ feedback loops
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

# Steering Software

In pattern 2, a plan is the sum of its steps:

> It’s possible to make a project plan and follow it exactly.

In pattern 3, a plan gives orientation on where a projects stands:

> Plans are rough guides. We need steering to stay on course.

In order to steer a project, not only meaningful measurements based on accurate
effect models are needed, but also models on how interventions will affect the
system under control. (If plans always could be followed strictly, interventions
would be futile.)

Unlike pattern 1, pattern 2 works with plans, often wrapped into methologies
(i.e. the Waterfall Model), which describe an ideal series of steps.

In classic Waterfall, there’s no going back:

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

Sequential methods are like turn-by-turn directions that don’t consider
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
of a phase. However, waiting for such a phase to end (“design“, “coding“) bears
risks:

- Not collecting feedback during a phase makes it impossible to detect  problems
  early on.
- Re-iterating a phase after a problem has been detected causes major
  disturbances in the whole process, say, doing a re-design after coding has
  been “finished“. Such “big” steps back are rather avoided than undertaken; the
  organization might go on with a flawed intermediate product to the next phase.

This methodology can be summarized as “doing it completely right or doing it
over“. There’s no notion of small deviations and according corrections.

Instead of one global process (Waterfall), a project can be split up in smaller
task cells that provide their own feedback loop (e.g. a User Story).

> Good intervention models will help us to understand what we can’t control, but
> a faulty model may lead us to overlook a number of effective interventions.

In Waterfall, it is assumed that every phase brings the project closer to the
desired state. However, in any phase there might happen things that bring the
project in a worse state:

- errors are introduced in the design and code
- project members get falsely confident
- project members burn out, quit
- conflicts between project members emerge; the no longer want to work together

Such model don’t account for “soft” factors, such as employees getting
frustrated or sick.

Errors introduced in the coding phase could originate in any of the (earlier)
phases (wrong requirements, erroneous analysis, bad design, bad coding).
However, they don’t manifest themselves before testing. Likewise, frustration
and tension might rise during the whole project, but the conflicts might only
erupt towards the (planned) end of the project.

Methodologies are often only product focused and don’t account for other outputs
(“soft” factors).

Pattern 2 managers often would rather hide in their offices and work with plans
rather than with human beings. The role of human action in project management is
often denied. However, human decision points are the places where a crisis can
be prevented.

> More software projects have gone awry _because their managers didn’t know how
> to respond to lack of calender time_ than for all other causes combined.

Loops that concern management contain decisions by people:

> Whenever there’s a human decision point in the system, it’s not the event that
> determines the next event, but someone’s _reaction_ to that event.

There are two types of laws concerning software engineering management:

1. “natural” laws (accept them)
2. “human decision laws” (learn to control them)

People often mistake human decision laws for natural laws:

- “We were late with coding, _therefore_ we had less time to test the
  application.”
    - _therefore_ suggests that a natural (or logic) law was followed
    - doing less testing was actually a human decision
- “We could not finish a proper design, but we _had to_ start coding, _because_
  time for design was up.”
    - _because_ suggests that one should start implementing an unfinished design
      when the clock tells you so
    - continuing with an unfinished design was a human decision

Pay attention to words that suggest a logical succession of events, such as “had
to“, “because“, “therefore“, and ask for the _reasoning behind_ it. Record
instances of human reasoning disguised as laws of nature.

# Failing to Steer

In pattern 2, managers only plan what should happen. In pattern 3, they should
also: observe, compare the observed to the planned, and take actions to move the
observed closer to the planned.

There are three dynamics standing in their way:

1. Victim Mentality
    - When bad things happen, managers fail to see their points of action.
      However, what counts are not only those events, but also (and foremost)
      the reactions to those events. “Victim language” can be reframed as
      “Controller language“.
    - Brooks’ Law (adding people to a late projects makes it later) can be
      mitigated: As long as the added staff doesn’t interfere with the existing
      staff’s process, they still can add value (checking and improving
      documentation, reviewing code, creating test cases, do chores for others
      in the project group).
2. Suppressing “Negative Talk”
    - If employees are punished for negative reports, they’re incentivized to
      produce rosy looking fake reports:
        - quick and dirty fixes to problems so that they don’t have to be
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
      lost. As more defects occur, the manager reacts by putting “recovery
      functions” into the product in order to make up for the defects. The
      software project falls even more behind schedule, and quality detoriates
      even further, which requires more “recovery functions“. The customer, who
      has to wait longer, wants to be rewarded for his patience—by asking for
      more features. This creates a vicious cycle.
    - The control points are working backwards: every intervention makes the
      problems worse. In this case, the interventions just need to be reversed.
      In the above example, a trust period is introduced, so that the developers
      can catch up and improve the product’s quality.
    - Two parties blaming each other creates a mutually destructive feedback
      loop. This can be solved with a better understanding of the system—unless
      the two parties have gotton too far from each other and prefer revenge
      over reconciliation.
    - Tools do not determine how they are being used. They can be applied for
      the worse or for the better.

# Why It’s Always Hard to Steer

When the dynamics of a  process is regulated by human decisions, _intervention
dynamics_ is at play. When human decisions have no power to alterate the dynamic
of a process, _natural dynamic_ is at play. A stone of a certain weight can be
lifted by a human for some time (intervention dynamics), but gravity constrains
that process in the long run (natural dynamic). Likewise, a manager can increase
the output of a team by letting its members work overtime (intervention
dynamics), but the returns will diminish after some time (natural dynamics).
Natural dynamics limit the effect interventions can have.

The _Square Law of Computation_ limits what a mind (i.e. a brain or a group of
brains) can accomplish. In order to keep a system under control, a model to
compute effects of interventions is required. A model can be expressed as a set
of equations with roughly one equation per relevant measurement in the system.

> Unless some simplification can be made, the amount of computation to solve a
> set of equations increases at least as fast as the square of the number of
> equations. (Square Law of Computation)

A software project can be modeled as a game, in which a control strategy is
applied to go from an initial bad state (present position) to a final good state
(winning position). In a deterministic game, the player is in the position of
the perfect controller. There is no randomness, and the model covers all
possible ways a game can unfold (moves and countermoves). Tic Tac Toe and Chess
are both games that—theoretically—allow for perfect control. However, there are
orders of magnitude more ways a game of Chess can unfold than a game of Tic Tac
Toe. Therefore, there’s no perfect model (yet) to play chess. Instead, _general
principles_ (heuristics) are applied to reduce the set of _possible moves_ to a
much smaller set of _most promising moves_, which makes the game much more
manageable (e.g. don’t sacrifice your queen to capture a pawn) with limited
computing capacity. Such general principles are useful _most of the time_ but
might prevent the best play  _some of the time_.

Software engineering is way more complex and noisy (more randomness) than Chess.
Consider machine instructions as moves in the game, and the number of
instructions needed for a significant program (thousands, millions?) compared to
a game of Chess, which usually ends before 100 moves are played. However,
software engineering efforts are directed at reducing such non-linearities to
keep the Square Law of Computation under control, which is also accomplished by
applying general principles, such as:

- Don’t add people late in a project to catch up. (Brooks’ Law)
- Use the smallest possible team of the best possible people.
- Don’t shoot the messenger.
- Break your code up into modules.

These general principles are the simplifications (“Unless some simplifications
can be made“) of the Square Law of Computation. Collections of such general
principles make up the cultural pattern of a software organization. Such guiding
principles are needed because of the _Size/Complexity dynamic_:

> Human brain capacity is more or less fixed, but software complexity grows at
> least as fast as the square of the size of the program.

When a software project succeeds, ambitions rise, and the problems being
attempted to solve grow bigger. Bigger (and harder) problems drive an
organization to new, yet untried patterns. (If there’s no ambition for solving
harder problems or achieving better quality, an organization can stay with its
current pattern.)

It’s hardly possible to alter the capacity of our brains (hiring smarter people
only works to some extent), but it’s possible to alter how much of our capacity
is used, and for what purpose. Software engineering attempts to simplify the
solutions to larger problems—raising the success rate in response to higher
ambition.

A software project an be seen as a game against nature. The interventions of a
controller (moves) can be measured as effects (countermoves by nature). When the
controller sees that nature moves the project on the losing path, an
intervention move is required to bring it back to the winning path.

The _Fault Location_ dynamic states that under a constant error rate (say, one
bug introduced per developer and sprint), a larger system contains more faults
(Size/Complexity dynamic). The effect required to locate errors therefore grows
non-linearly. The Fault Location dynamic is a natural dynamic, not the result of
developers performing worse. Pattern 2 managers miss this point and apply
the wrong interventions; trying to work against nature. Both Size/Complexity and
Fault Location dynamic can be tackled using modularization.

The _Human Interaction_ dynamic states that the number of interactions between
people grows non-linearly to the amount of people being added to a project.

# What it Takes to Be Helpful

The computational power required to control a project grows non-linearly with
the problem size. Due to this non-linearity, being twice as smart does _not_
allow you to solve problems twice as big:

> Ambitious requirements can easily outstrip even the brightest developer’s
> mental capacity.

Given a program that is capable of playing the perfect game of chess: If the
board’s size is increased from 8x8 (64) to 10x10 (100) fields, the number of
possible moves explodes, even though the board size only grows by roughly 50%.

Every pattern has its size/effort curve, showing how well it will do given
problems of different sizes. This curve grows non-linearly: Increasing
requirements by 10% causes an additional effort of way more than 10%. The bigger
the problem, the bigger the _growth rate_ of the effort.

Software projects are highly variable. Due to this noise, a linear curve often
fits almost as good as an exponential one in a size/effort graph. Plotting data
on a logarithmic scale might help better understanding the data, but also trick
the eye into seeing linear patterns (Log-Log-Law):

> Any set of data points forms a straight line if plotted on log-log paper.

Managers influence projects by choosing methods, tools, and people, which make
up an organization’s cultural pattern. Two different methods (or tools, or
teams) A and B will have different curves on a size/effort graph: Method A is
cheaper for small projects (say, due to less overhead), but reaches a limit of
feasible projects quite quickly. Method B, on the other hand, s more expensive
for small projects, but allows to deal with bigger projects than method A.

Therefore, organizations adopt _two_ (or more) methods instead of just one
“standard method” for software development, which are then picked from depending
on a project’s estimated size. This requires managers to take an important
decision at the beginning of every project: which method to choose? In a blaming
environment, taking such decisions can get a manager into trouble. Therefore,
they’d often prefer to have a “standard model” being imposed on them.

Managers choose their methods for other reasons than just effort. Risk is also a
very important factor. Depending on the problem size, different methods have
different chances of success. The bigger the project, the higher the risk, the
lower the chance of success.

Using a method for the first time is riskier and more effortful than doing so
for the umpteenth time. Managers are therefore reluctant to try out new methods,
patterns, languages, etc. The risk on the decision maker can be reduced by:

1. moving the decision to a higher level of management, so that the risk is
   spread wider (and higher)
2. reducing the size of the first project, which is intended to be a pilot
   project for learning (as opposed to getting attention)
3. reducing the criticality of the first project

Harm is rarely done out of malice, but of good intentions combined with wrong
assumptions about the underlying problem (wrong model). It is often being tried
to control systems that lie beyond one’s capacity:

- What one “knows” are often only simplifications (heuristics) carried over from
  simpler situations.
- One fails to see the true dynamics in an environment with lots of randomness.
  Once those dynamics are put under control one by one, the system gets stable
  enough for a transition from pattern 2 to pattern 3.
- Behaviours that might produce good results in the short run (e.g. deploying
  hacks to fix bugs, skip on testing to save time) cause trouble in the long
  run. One fails to see this connection, gets addicted to such a bad behaviour,
  and stays with the faulty intervention model—a disease of limited intelligence.

Some interventions cause more harm than good, so one might conclude that doing
harm is actually intended—which is very rarely the case! To analyze such
situations without getting paranoid, the _Helpful Model_ can be applied:

> No matter how it looks, everyone is _trying_ to be helpful.

This model takes away the blame and lets us look at the true dynamics, i.e.
beyond anybody’s intention.

Mental models can’t be eliminated, but only replaced by better ones (_Principle
of Addition_):

> The best way to reduce ineffective behaviour is by adding a more effective
> behaviour.

Organizations get addicted to certain practices, which relieve their pain in the
short run, but are harmful in the long run. The more a practice is applied, the
worse one feels, and the more one seeks the relief of the addictive behaviour.
Such harmful, addictictive practices can be countered by adding long range
measurements with according rewards and punishments.

Better than curing addictions is preventing them in the first place:

> The way people behave is not based on reality, but on their _models_ of
> reality.

Implanting more effective models is the most helpful intervention.

# Responses to Customer Demands

An organization expresses that it is in crisis by the attitudes towards its
customers. If it gets too entangled with its internal problems, it forgets its
reason for existence. Complaints about too many customers and their
“unreasonable” demands are uttered. The more customers an organization has, the
more requirements it needs to fulfill, the bigger the system becomes—and, due to
the Size/Complexity dynamic—the more complex. The chances of conflicting
requirements also grows, causing additional trouble to resolve—either by
implementation or explanation.

The more customer a software organization has, the higher the demands on it
grow. More features are requested, more errors reported, and more configurations
must be supported—and all this within shorter time spans. An organization under
such pressure must either omove to a new cultural pattern in order to cope with
those higher demands—or it reduces its number of (satisfied) customer. (Fewer
customers tend to expect having all their expectations met, whereas thousands of
customers have lower expectations, considering their lower relative importance
to the organization.)

Managers want to keep the systems under their control in a healthy state. They
want to keep both the amount and the extent of interference from the outside
low, because too much interference can be disruptive to a system working well.
Customers give inputs to a system (requirements, error reports, money), and in
turn expect outputs from that system (software satisfying their requirements,
error reports being handled in time, correctly, and professionally). Some of
those inputs cause random disturbances. Like the managers on the inside, the
customer acts as an external controller to the system. Sometimes, the internal
and external controller are in conflict, causing conflicts within the system.

Not every user is a paying customer, but every user has expectations on how a
software is supposed to behave. Most users also notice errors that need to be
dealt with. All users cause load on a system. Every user has requirements, but
only paying customers buy their right to define the quality by requirements.

The marketing department is a surrogate for customers that acts on behalf of
them within the organization. They represent the customers and users against the
developers—sometimes well, sometimes badly. Marketing is supposed to act as a
filter between customers and developers. It decreases disturbances from
customers, but is itself closer to the developers, and therefore more prone to
cause disturbances itself by bypassing all the defenses. The side effects of an
interfering marketing department can be worse than the benefits gained from
their filtering of customer inputs towards the developers.

Developers can act as customer surrogates themselves and influence software
directly—for the better or worse. In a variable culture (pattern 1), developers
act without explicit or approved customer requirements. Pattern 2 managers want
to eliminate such bypassing of processes. In an unstable organization,
programmers frequently make changes without unauthorized, some of them remaining
unnoticed internally (but not by the customers). The more programmers an
organization has, the more potentially dangerous customer surrogates it has to
deal with.

Testers are supposed to faithfully replicate customer use. However, they make
frequent implicit decisions about what they think the customer _really_ wants or
needs. Since they are usually closer to the developers than to the customers,
there are more prone to the influence of the former than the latter.

As the number of customers increases, the amount of customer interactions
increases, too, usually non-linearly. The cost of an interruption is not only
the duration of the interruption itself (say, a five minute customer call), but
also an additional reimmersion time needed to get back to the original task (say,
fifteen minutes). The more people that are affected by a single
interruption―say, a phone call pulling a meeting attendee away, causing the
whole meeting to be interrupted—the longer the reimmersion time becomes:
Gathering a dispersed crowd costs time—and requires interrupting them at the
task they picked up in the meantime.

The number and size of meetings grows as the customer base grows. After a
certain amount of customers is reached, it is no longer possible to satisfy
their needs completely all the time. The number of possible configurations
(combinations of different platforms, versions used, integrations with other
software, customized software parts) starts to grow exponentially over time.
More configurations remain untested, causing more error reports. Those cause
more patches being deployed, which become harder to test on different
configurations. A software organization either changes its culture—or lowers the
level of support provided for its customers.

When software is releases, it is passed from one group (developers) to another
(customers). It is started being used productively. The release initiates a
couple of important dynamics:

- Multiple versions of a software now exist, which all need to be maintained.
- More errors are found and reported at a faster rate by actual users.
- Reported errors need to be fixed more quickly: Development is not driven by an
  external clock.
- Deploying faulty patches becomes much more expensive—and causes trouble for
  more customers. Also, the same errors are reported by multiple parties, which
  multiplies the amount of interactions for a single error.
- If individual patches are deployed for single customers, the system becomes
  harder to understand and maintain, especially if the patch was is poorely
  documented.
- All those problems need to be dealt with quickly—disrupting the development
  process of the entire organization, which leads to poorer quality and more
  stress in the long run. A vicious cycle unleashes.

Issuing fewer releases with higher quality can break those negative,
self-reinforcing dynamics. Many mature organizations release their software
only twice a year. Organizations also start to prioritize their customers.
“Nice” customers that pay more are better served than “nasty” ones that pay
less.
