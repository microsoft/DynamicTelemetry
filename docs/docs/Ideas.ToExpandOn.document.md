Ef>{&H%yRB---
author: "Chris Gray"
status: ReviewLevel1
---

# Ideas: Interesting Thoughts That Haven't Found Their Way into Docs

## Using Ingestion Processor to Hold Metadata to Streamline Air Interfaces

The idea is to introduce a stateless means to send larger pieces of information
that would be useful to attach to every log message but would otherwise be
expensive. The mechanism would create a key-value pair such that every log
message emitted will be merged by the backend with the value attached to the
key.

As an example, imagine some census information that includes the CPU and RAM
capabilities of the machine. This information is attached to every log record on
the backend. This attachment could be in the form of a join key or could be
directly attached. Every log message would be able to "see" this information,
but would not have to carry the information.
