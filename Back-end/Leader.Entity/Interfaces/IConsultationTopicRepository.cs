using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IConsultationTopicRepository : IBaseRepository<ConsultationTopic>
{
    Task<List<ConsultationTopic>> GetBySubDepartmentId(int subDepartmentId, CancellationToken ct);
}