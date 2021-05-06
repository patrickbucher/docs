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
