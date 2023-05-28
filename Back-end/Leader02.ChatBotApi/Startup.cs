// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
//
// Generated with Bot Builder V4 SDK Template for Visual Studio CoreBot v4.18.1

using Leader.Domain.Interfaces;
using Leader02.ChatBotApi.Bots;
using Leader02.ChatBotApi.Dialogs;
using Leader02.Infrastructure;
using Leader02.Infrastructure.Repositories;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Bot.Builder;
using Microsoft.Bot.Builder.Integration.AspNet.Core;
using Microsoft.Bot.Connector.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Leader02.ChatBotApi;

public class Startup
{
    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddHttpClient().AddControllers().AddNewtonsoftJson(options =>
        {
            options.SerializerSettings.MaxDepth = HttpHelper.BotMessageSerializerSettings.MaxDepth;
        });

        services.AddDbContext<Leader02Context>(options =>
            options.UseNpgsql("Host=localhost;Port=5432;Database=Leader02;Username=postgres;Password=admin"));

        services.AddRepositories();
        services.AddServices();
        
        // Create the Bot Framework Authentication to be used with the Bot Adapter.
        services.AddSingleton<BotFrameworkAuthentication, ConfigurationBotFrameworkAuthentication>();

        // Create the Bot Adapter with error handling enabled.
        services.AddSingleton<IBotFrameworkHttpAdapter, AdapterWithErrorHandler>();

        // Create the storage we'll be using for User and Conversation state. (Memory is great for testing purposes.)
        services.AddSingleton<IStorage, MemoryStorage>();

        // Create the User state. (Used in this bot's Dialog implementation.)
        services.AddSingleton<UserState>();

        // Create the Conversation state. (Used by the Dialog system itself.)
        services.AddSingleton<ConversationState>();

        services.AddDialogs();

        // Create the bot as a transient. In this case the ASP Controller is expecting an IBot.
        services.AddTransient<IBot, DialogAndWelcomeBot<MainDialog>>();
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }

        app.UseDefaultFiles()
            .UseStaticFiles()
            .UseWebSockets()
            .UseRouting()
            .UseAuthorization()
            .UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

        // app.UseHttpsRedirection();
    }
}