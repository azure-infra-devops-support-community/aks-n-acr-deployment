using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Threading.Tasks;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

int counter = 0;
int max = args.Length > 0 ? Convert.ToInt32(args[0]) : -1;

app.MapGet("/", () => $"Counter: {counter}");

app.MapGet("/increment", async () =>
{
    if (max == -1 || counter < max)
    {
        counter++;
        return $"Counter: {counter}";
    }
    return "Counter limit reached!";
});

app.Run();
