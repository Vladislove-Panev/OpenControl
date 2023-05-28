using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IConsultationTopicService
{
    Task<List<ConsultationTopicDto>?> GetAllBySubDepartmentId(int subDepartmentId, CancellationToken ct);
}