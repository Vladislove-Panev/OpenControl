using Leader.Domain.Interfaces;
using Leader02.Application.IServices;
using Leader02.Application.Jwt;
using Leader02.Application.Services;
using Leader02.Infrastructure.Repositories;

namespace Leader02.Api;

public static class DiExtensions
{
    public static void AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IDepartmentUserRepository, DepartmentUserRepository>();
        services.AddScoped<IAdminUserRepository, AdminUserRepository>();
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IChatBotRequestMessageRepository, ChatBotRequestMessageRepository>();
        services.AddScoped<IChatBotRequestRepository, ChatBotRequestRepository>();
        services.AddScoped<IConsultationTopicRepository, ConsultationTopicRepository>();
        services.AddScoped<IConsultationSlotRepository, ConsultationSlotRepository>();
        services.AddScoped<IConsultationRepository, ConsultationRepository>();
        services.AddScoped<ISubDepartmentTsVectorRepository, SubDepartmentTsVectorRepository>();
        services.AddScoped<ISubDepartmentRepository, SubDepartmentRepository>();
        services.AddScoped<IDepartmentRepository, DepartmentRepository>();
        services.AddScoped<ILegalActTsVectorRepository, LegalActTsVectorRepository>();
        services.AddScoped<ILegalActRepository, LegalActRepository>();
        services.AddScoped<IOpenControlServiceRepository, OpenControlServiceRepository>();
        services.AddScoped<IRequirementTsVectorRepository, RequirementTsVectorRepository>();
        services.AddScoped<IRequirementRepository, RequirementRepository>();
    }

    public static void AddServices(this IServiceCollection services)
    {
        services.AddSingleton<IJwtUtils, JwtUtils>();
        services.AddSingleton<IAuthService, AuthService>();
        services.AddSingleton<IUserService, UserService>();
        services.AddSingleton<IAdminUserService, AdminUserService>();
        services.AddSingleton<IDepartmentUserService, DepartmentUserService>();
        services.AddSingleton<IChatBotRequestService, ChatBotRequestService>();
        services.AddSingleton<IChatBotRequestMessageService, ChatBotRequestMessageService>();
        services.AddSingleton<IConsultationService, ConsultationService>();
        services.AddSingleton<IConsultationSlotService, ConsultationSlotService>();
        services.AddSingleton<IConsultationTopicService, ConsultationTopicService>();
        services.AddSingleton<IDepartmentService, DepartmentService>();
        services.AddSingleton<ISubDepartmentService, SubDepartmentService>();
        services.AddSingleton<ILegalActService, LegalActService>();
        services.AddSingleton<IOpenControlServiceService, OpenControlServiceService>();
        services.AddSingleton<IRequirementService, RequirementService>();
    }
}