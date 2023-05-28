using Leader.Domain.Interfaces;
using Leader02.Application.IServices;
using Leader02.Application.Services;
using Leader02.ChatBotApi.Dialogs;
using Leader02.Infrastructure.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.ChatBotApi;

public static class DiExtensions
{
    public static void AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IRequirementRepository, RequirementRepository>();
        services.AddScoped<IRequirementTsVectorRepository, RequirementTsVectorRepository>();
        services.AddScoped<ILegalActRepository, LegalActRepository>();
        services.AddScoped<ILegalActTsVectorRepository, LegalActTsVectorRepository>();
        services.AddScoped<ISubDepartmentRepository, SubDepartmentRepository>();
        services.AddScoped<ISubDepartmentTsVectorRepository, SubDepartmentTsVectorRepository>();
    }

    public static void AddServices(this IServiceCollection services)
    {
        services.AddSingleton<IRequirementService, RequirementService>();
        services.AddSingleton<ILegalActService, LegalActService>();
        services.AddSingleton<IDepartmentService, DepartmentService>();
        services.AddSingleton<ISubDepartmentService, SubDepartmentService>();
    }

    public static void AddDialogs(this IServiceCollection services)
    {
        services.AddSingleton<ConsultationDialog>();
        services.AddSingleton<FeedBackDialog>();
        services.AddSingleton<RepeatQuestionDialog>();
        services.AddSingleton<MainDialog>();
    }
}