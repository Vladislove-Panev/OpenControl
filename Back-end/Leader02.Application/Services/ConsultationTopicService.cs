using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class ConsultationTopicService : IConsultationTopicService
{
    private readonly IConsultationTopicRepository _consultationTopicRepository;

    public ConsultationTopicService(IServiceScopeFactory serviceScopeFactory)
    {
        _consultationTopicRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IConsultationTopicRepository>();
    }

    public async Task<List<ConsultationTopicDto>?> GetAllBySubDepartmentId(int subDepartmentId, CancellationToken ct)
    {
        var consultationTopics = await _consultationTopicRepository.GetBySubDepartmentId(subDepartmentId, ct);
        if (consultationTopics.Count == 0)
            return null;

        return consultationTopics.ConsultationTopicsToConsultationTopicsDto();
    }
}