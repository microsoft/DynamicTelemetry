using Azure.Identity;
using Azure.Monitor.OpenTelemetry.AspNetCore;
using System.Diagnostics;
var builder = WebApplication.CreateBuilder(args);


// Add services to the container.
builder.Services.AddRazorPages();

if (!Debugger.IsAttached)
{
    // Add OpenTelemetry and configure it to use Azure Monitor
    builder.Services.AddOpenTelemetry()
        .UseAzureMonitor();
}

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();
