using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface ISubDepartmentRepository : IBaseRepository<SubDepartment>
{
    Task<SubDepartment?> GetById(int id, CancellationToken ct);
    Task<List<SubDepartment>> GetAllByDepartmentId(int departmentId, CancellationToken ct);
    Task<List<(int, string)>> GetAllName(string name, CancellationToken ct);
    Task<List<(int, string)>> GetAllDescription(string description, CancellationToken ct);
}