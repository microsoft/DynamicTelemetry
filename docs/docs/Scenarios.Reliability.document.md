# Reliability

In the ever-evolving landscape of software development, testing has
become more than just a mechanical process --- there has become an art
form. Some of this art stems from the siloed theories that come from
fast paced development cycles, mixed with differing test strategies.
Unit testing, stress testing, scenario testing, scale testing, fuzz
testing, and penetration testing each have their own methodologies,
strengths and weaknesses, making it challenging to achieve a cohesive
testing strategy on a strict time budget.

Enter Dynamic Telemetry, a revolutionary approach that transforms
traditional testing into a holistic system monitoring experience. By
seamlessly incorporating tests and key indicators directly into the
production code, Dynamic Telemetry opens the door to new statistical and
AI methods of observing a system.

With Dynamic Telemetry, your test assets are broken into five pillars

##  Self-describing Production Code:

Dynamic telemetry takes advantage of the durable identifiers and
structure payloads within your logging and metrics in order to provide
loose schemas that can be used in self-describing quality
characteristics of code. While these topics are discussed further in
other sections, the key aspect can be summarized as Lightweight
telemetry that signals positive failure, or can otherwise indicate
operational characteristics

[Self Describing Production Code](./docs/PositionPaper.SelfDescribingProductionCode.document.md)

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

[Internal Audits of Production Code](./docs/PositionPaper.InternalAuditsOfProductionCode.document.md)

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

[External Audits of Production Code](./docs/PositionPaper.ExternalAuditsOfProductionCode.document.md)

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

[Testing With Entropy](/docs/PositionPaper.TestingWithEntropy.document.md)

##  Diagnostic Collection

Diagnostic collection essentially involves gathering the content that
programmers or operational teams deem necessary for diagnosing system
failures. Dynamic telemetry defines an error as an issue requiring
investigation, therefore providing clear guidance, and total clarity of
expectation, on the subsequent steps and specifying what needs to be
collected.

1. Should an internal external test fail
1. Collect what the developer said they need

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

##  Appropriate Alerts

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
