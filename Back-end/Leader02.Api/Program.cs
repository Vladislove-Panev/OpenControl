using System.Globalization;
using Leader02.Api;
using Leader02.Api.Configs;
using Leader02.Application.Jwt;
using Leader02.Infrastructure;
using Microsoft.AspNetCore.Localization;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

var configuration = builder.Configuration;


builder.Services.AddDbContext<Leader02Context>(options =>
    options.UseNpgsql(configuration.GetConnectionString("Leader02")));

builder.Services.AddSingleton<IJwtConfig>(JwtConfig.Create(configuration));

builder.Services.AddRepositories();
builder.Services.AddServices();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

var defaultDateCulture = "ru-RU";
var ci = new CultureInfo(defaultDateCulture)
{
    NumberFormat =
    {
        NumberDecimalSeparator = ".",
        CurrencyDecimalSeparator = "."
    }
};

// Configure the Localization middleware
app.UseRequestLocalization(new RequestLocalizationOptions
{
    DefaultRequestCulture = new RequestCulture(ci),
    SupportedCultures = new List<CultureInfo>
    {
        ci,
    },
    SupportedUICultures = new List<CultureInfo>
    {
        ci,
    }
});
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseDeveloperExceptionPage();
}

//app.UseHttpsRedirection();

app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

