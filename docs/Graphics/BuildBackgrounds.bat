
set TOOL="C:\Program Files\wkhtmltopdf\bin\wkhtmltoimage.exe"
set BASE="file:///C:/Source/DynamicTelemetry/docs/Graphics/Banner.Template.html"

%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Cost%%20Savings" ../orig_media/CostSavings.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Durability" ../orig_media/Durability.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Perf%%20and%%20Debugging" ../orig_media/PerformanceAndDiagnostics.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Secrets%%20and%%20Security" ../orig_media/RedactingSecrets.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Reliability" ../orig_media/Reliability.banner.png


%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Flight%%20Recorders" ../orig_media/FlightRecorders.banner.png


%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Flight%%20Recorders" ../orig_media/FlightRecorders.banner.png


%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Trace%%20Horizons" ../orig_media/TraceHorizons.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Short%%20Horizon" ../orig_media/ShortHorizon.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Long%%20Horizon" ../orig_media/LongHorizon.banner.png
%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Cubby%%20Hole%%20Horizon" ../orig_media/CubbyHole.banner.png


%TOOL% --debug-javascript --enable-local-file-access "%BASE%?title=Key Constructs" ../orig_media/KeyConstructs.banner.png


