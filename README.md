# Project

*You're at the main github location hosting the unrendered markdown for Dynamic
Telemetry.  If you'd prefer more pleasing to read, rendered HTML, please visit
[https://microsoft.github.io/DynamicTelemetry/](https://microsoft.github.io/DynamicTelemetry/).

Dynamic Telemetry is proposal for an open-source diagnostic tool
designed to complement OpenTelemetry by making debugging highly scaled
production software as easy and enjoyable as debugging a single
application locally. Our goal is to enable you to diagnose and explore
live production systems without compromising reliability, performance,
or customer privacy.

Dynamic Telemetry blends traditional symbolic debuggers with advanced
new complements to your existing OpenTelemetry assets and workflows. It
introduces five architectural components that, when used together, bring
the peace and calm of local debugging into the distributed cloud.

In this draft, we aim to encourage discussion of hard problems in
public. We want to foster a collaborative environment where we can
tackle challenges such as:

- Performance and Diagnostics: Quickly trigger memory dumps or collect
    CPU samples during production issues. Deploy observers to monitor
    telemetry and gather extra diagnostic data only when needed.
- Privacy and Security: Detect and immediately suppress sensitive
    fields within logs, such as PATs, IP addresses, user information, or
    crypto keys.
- Reliability: Test your services more effectively by making your
    production code self-diagnose. Couple self-diagnostics with actions
    that toggle up and down telemetry volume, collect memory dumps, and
    CPU samples.
- Durability: Develop flexible schemas in your logs, metrics, and
    traces that enhance the durability of your dashboards and streamline
    communication between coworkers.
- Cost Reduction: Convert verbose logs into concise metrics, suppress
    large payloads, or drop unnecessary logs.

We invite you to join us in this journey to improve system stability and
performance through Dynamic Telemetry. Let's work together to address
these challenges and make debugging in production environments more
efficient and effective.

Feel free to modify this draft as needed. Let us know if there's
anything else you'd like to add or change!

## Contributing

This project welcomes contributions and suggestions. Most contributions
require you to agree to a Contributor License Agreement (CLA) declaring
that you have the right to, and actually do, grant us the rights to use
your contribution. For details, visit
[https://cla.opensource.microsoft.com](https://cla.opensource.microsoft.com).

When you submit a pull request, a CLA bot will automatically determine
whether you need to provide a CLA and decorate the PR appropriately
(e.g., status check, comment). Simply follow the instructions provided
by the bot. You will only need to do this once across all repos using
our CLA.

This project has adopted the [Microsoft Open Source Code of
Conduct](https://opensource.microsoft.com/codeofconduct/). For more
information see the [Code of Conduct
FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact
<opencode@microsoft.com> with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or
services. Authorized use of Microsoft trademarks or logos is subject to
and must follow [Microsoft's Trademark & Brand
Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this
project must not cause confusion or imply Microsoft sponsorship. Any use
of third-party trademarks or logos are subject to those third-party's
policies.
