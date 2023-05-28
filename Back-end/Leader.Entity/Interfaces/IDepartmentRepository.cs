using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IDepartmentRepository : IBaseRepository<Department>
{
    Task<Department> GetById(int id, CancellationToken ct);
    Task<List<(int, string)>> GetAllAbbreviation(string abbreviation, CancellationToken ct);
    Task<List<(int, string)>> GetAllName(string name, CancellationToken ct);
    Task<List<(int, string)>> GetAllDescription(string description, CancellationToken ct);
}