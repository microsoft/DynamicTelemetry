# Reliability

After you apply some thinking into probing an action aspects of dynamic
telemetry you may come to realize that using these facilities provide an
interesting methodology for testing and hardening production systems.

Traditional testing requires decoupling of the software from into
smaller pieces each of which are tested independently often these are
called unit tests. Is this complexity of the software grows unit tests
remain useful but often struggle to detect integration type failures.

To cope with this many developers will start using scenario testing
which blends together different architectural components into one
logical set which is then tested as a entire scenario. Should the
scenario fail the developer will start zooming in on the area has been a
gration that failed and from there they will look into the logging of
the system often communicating in a bug fix and the addition of a unit
test.

The systems aren\'t bad in fact pretty good but a problem emerges when
the complexity of this system gets very large perhaps it spans multiple
machines multiple geographies multiple locations, perhaps the hardware
architecture spends spans multiple devices some of which are in the
cloud and some of which are on the edge.

As the complexity grows many developers simply get frustrated and in
some ways give up.

Dynamic telemetry introduces an interesting set of capabilities that
when reasoned over result in a interesting hybrid between scenario and
unit tests.

The idea is to to use the logging and metrics found within a piece of
software to self describe desired and expected behavior such that the
product itself could detect its own failures.

In itself this is not a novel or new concept in fact entire books have
been written on the subject.

What is interesting and potentially is novel is the idea of using a
combination of one box and off box observers to this lightly schematized
telemetry to look for patterns and failures that wouldn\'t be
necessarily caught within a unit test or scenario test.

This is especially true as a systems complexity grows into stress
testing or penetration testing where network fuzzing or payload fuzzing
has been enabled.

The remainder of this section will discuss a different way of thinking
about testing and improving the reliability of a system such that the
code itself is architected to self diagnose and in the event that a
failure occurs the programmer will automatically get the desired set of
diagnostics to fix the problem.

Imagine in your software the software to some degree self-described
failure. Perhaps when you author a inque operation there\'s an
expectation in programming of how long that operation will take before
it\'s fully completed in the code when you use a queue you could insert
the item into a queue and say it is expected that the processing of this
payload will have completed within 200 milliseconds.

Should the completion take longer than 200 milliseconds this would
indicate a warning perhaps it\'s not fatal perhaps the programmer
shouldn\'t even look at it. However maybe at one second this does
indicate it a failure that needs to be inspected.

The actions portion of dynamic telemetry permit a developer to select
their preferred type of diagnostic information in the event that one of
the pieces of software they\'re authoring it behaves in a way that is
not expected.

Further, the operating nominal operating characteristics may not
necessarily be specified at right at build time they may actually be
configured or deployed dynamically at runtime.

This concept of self describing operational state is extremely
interesting when a when coupled with dynamic configuration in the
telemetry system, because opportunity is created for these values to be
trained into the system instead of programmed in.

These concepts will be expanded in further sections but they\'re worth
thought.

With Dynamic Telemetry, your test assets are broken into five pillars

## Failure depends on the environment

After careful consideration of using the telemetry system as a means of
inner processor remote communication, it becomes evident that such a
system can signal an external test when a failure occurs. This
realization allows developers to write code that is easy to diagnose.
The code itself aims to assist in detecting bugs, and the operational
environment, through dynamic telemetry, supports both the programmer and
the program in this endeavor.

We will introduce two key concepts that are elaborated upon further in
the documentation and are essential for comprehensive understanding.
These concepts are probes and actions. A probe, in its simplest form, is
nothing more than a log or metric emitted by a piece of code, for
example, when a file is opened. The log may include the file name and
the return code from the open system call.

An action is part of a dynamically deployed processor that monitors the
operational characteristics of the system either internally within the
process, externally on the same computer, or even remotely from a
backend. The action listens to logging and metrics as they are
generated. When a particular log or metric with a specific failure code
of interest is emitted, the action can trigger rich diagnostic
collections, which may include a memory dump, a CPU sample, or could
enable the collection of more verbose logs.

At this point, you may be considering innovative ways to utilize these
capabilities. For instance, you could establish a queue with an external
observer that initiates a failure indicator if the queue becomes
completely empty or exceeds a predetermined limit. You might be
wondering what this preset number should be. It is important to note
that dynamic telemetry does not specify these details; instead, it
provides the fundamental constructs necessary to build such objects.

One could envision a queue object where, upon initialization, diagnostic
configurations are provided by the developer that include the minimum
and maximum expected lengths of the queue. Perhaps this queue contains
an expected flow rate. You can quickly imagine how an internal external
observer could initiate diagnostic collections should any of these
parameters we operating outside of specification.

Experienced programmers may understandably become concerned about the
accuracy of hardcoded values. Consider a scenario where a queue is
designed for specific hardware, but over time, as hardware evolves and
becomes faster, the queue links could either expand or contract
accordingly. Additionally, queue depths might fluctuate based on varying
usage patterns throughout the day across different regions.

The apprehension of such programmers is justified. However, the concept
of dynamic telemetry addresses these concerns by allowing programmers to
specify nominal values during the initial setup on the expected
hardware. In cases where these initial guesses are incorrect, dynamic
telemetry supports a training process that measures and adjusts these
values based on the new hardware or environment being utilized.

...in short, the hardcoded values are reasonable guesses; the real
values will be specified during operational training, on real hardware,
with real workloads.

... if this is interesting, now imagine you have different environments
where the same code is executing, each having different configurations
for failure attached - for instance, in a unit testing environment, one
set of configurations is applied. In contrast, a different configuration
set is used for scenario testing, and yet another set for stress or fuzz
testing.

Later in this section, we will further elaborate and provide detailed
examples.

## Self-describing Production Code:

Dynamic telemetry takes advantage of the durable identifiers and
structure payloads within your logging in order to provide loose schemas
that can be used in self-describing quality characteristics of code.
While these topics are discussed further in other sections, the key
aspect can be summarized as Lightweight telemetry that signals positive
failure, or can otherwise indicate operational characteristics

[Self Describing Production
Code](./docs/PositionPaper.SelfDescribingProductionCode.document.md)

## Internal Auditing of Production Code:

An internal audit production code involves creating classifications of
errors that adhere to strict definitions, unlike the flexible
classifications often found in other logging and telemetry systems.
Specifically, this means that an error must clearly describe something
exceptional that is not permitted. Every identified error requires
investigation until resolved.

For instance, the failure to open a key database file is an example of
an error worth investigating, whereas the failure to open a user file
may not be considered a failure. The distinction may seem subtle but is
significant. For example, in a library that processes files, treating
the failure to open a file as an error might be inappropriate. This type
of failure might be flagged as a warning, whereas higher layers might
treat it as a critical error, such as with a database.

[Internal Audits of Production
Code](./docs/PositionPaper.InternalAuditsOfProductionCode.document.md)

## External Auditing of Production Code

An external audit of the code introduces environmental characteristics
to the code. For example, what might be a programmatic warning internal
to the code could be treated as an error by an external observer.

This is where the power of dynamic telemetry can be found. This power
allows for the training of nominal operating characteristics for a
particular environment on specific hardware. The external observer
should be viewed as an advocate for the user within the operational
environment.

Imagine code in a unit test environment treating particular failures
with extreme strictness; perhaps any file error is treated as an error
worth investigating. However, as the code migrates from unit testing to
scenario testing, the threshold for an investigated failure may shift.

As the code enters the stress environment, the opposite characteristics
may be applied. For instance, the inability to open a file may no longer
be treated as an error but rather as a success.

In all cases, however, failures encountered during fuzz testing are
consistently regarded as errors worthy of further study.

The ability to redefine what is a error worth investigating at runtime
without recompilation is a key value of Dynamic Telemetry.

[External Audits of Production
Code](./docs/PositionPaper.ExternalAuditsOfProductionCode.document.md)

## Entropy Creators

As you explore using telemetry to pass and fail tests, and consider
different layers of testing as your code\'s execution environment
changes, it becomes clear how crucial unit testing, stress testing, and
scenario testing are. This method offers a powerful solution to many
complex software issues by defining the characteristics you want to
verify through tests that are dynamically attached to the software as
external observers.

Once these tests are attached as observers, they can be monitored from
various points. At this stage, the test engineer needs to design tests
that introduce enough entropy into the system to determine if the test
passes or fails. This testing approach is quite fascinating and aligns
with some philosophical principles in unit testing, deserving further
consideration.

[Testing With
Entropy](/docs/PositionPaper.TestingWithEntropy.document.md)

## Diagnostic Collection

Diagnostic collection essentially involves gathering the content that
programmers or operational teams deem necessary for diagnosing system
failures. Dynamic telemetry defines an error as an issue requiring
investigation, therefore providing clear guidance, and total clarity of
expectation, on the subsequent steps and specifying what needs to be
collected.

1.  Should an internal external test fail
2.  Collect what the developer said they need

It cannot get simpler. Best of all, with dynamic telemetry, the cost of
mistakes is low. Clear expectations do not guarantee unique logs, memory
dumps, or CPU traces when issues arise. Different personas, such as the
operational team or program management team, also set equally clear
expectations.

These balances are explored more deeply in the diagnostic collection
sections. In short though; simply because a developer clearly requests a
memory dump for minor issues or seek extensive CPU sampling, they may
not get what they want -- because their operational team set equally
clear guidance on topics like memory, disk, and CPU usage.

## Appropriate Alerts

This innovative approach ensures that every aspect of the software is
continuously monitored, providing real-time insights and enabling
proactive responses to potential issues. With Dynamic Telemetry,
developers can achieve unparalleled levels of observability, making it
easier than ever to maintain the reliability and performance of their
systems. Embrace the future of testing with Dynamic Telemetry and
experience the power of comprehensive, real-time system monitoring.

Dynamic Telemetry addresses these challenges by integrating testing into
the production code and leveraging both internal and external
observations. This approach bridges the gap between multiple
disciplines, allowing for singular functionality runs that encompass
various testing methods. By doing so, Dynamic Telemetry provides a
unified and efficient testing framework that enhances system reliability
and performance.

## Traditional "Testing" - Telemetry, Analysis, and Informing

Traditional testing often involves a series of predefined tests that are
run in a controlled environment to ensure that the software behaves as
expected. One crucial aspect of this process is emitting signals. Often
these signals are the comfortable primitives taught in school - error
codes, crashs, or thrown exceptions.

By emitting these signals during testing, developers can monitor the
system's performance and identify any anomalies or failures.

Once the signals are emitted, the next step is studying the results.
This involves analyzing the collected data to understand the system's
behavior and identify any potential issues. The developer will use the
simplified failures (error codes, crashes, or thrown exceptions) as
indication that the software is not performing to specification, and
will then open up log files and source code to figure out what happened.

Finally, it's essential to inform the operator about the test results.
This can be done through alerts or dashboards that provide real-time
updates on the system's status. If a test case fails or a dashboard
alert goes off, the operator can quickly take action to address the
issue. This proactive approach helps prevent potential problems from
escalating and ensures that the system remains stable and reliable. By
incorporating these steps into the test pipeline, organizations can
achieve a higher level of observability and maintain the quality of
their software123.

## How to Think about Testing, in a world of Dynamic Telemetry

## Dynamic Telemetry Pillars of Testing

### Self describing Production Code

### Internal Auditing of Production Code

### External Auditing of Production Code

### Entropy Creators

### Diagnostic Collection

### Appropriate Alerts

## How to Create Quality Analysis Rings
