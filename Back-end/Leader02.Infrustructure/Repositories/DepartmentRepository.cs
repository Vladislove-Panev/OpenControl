using Leader.Domain.Entity;
using Leader.Domain.Interfaces;

namespace Leader02.Infrastructure.Repositories;

public class DepartmentRepository : BaseRepository<Department>, IDepartmentRepository
{
    public DepartmentRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public Task<Department> GetById(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<(int, string)>> GetAllAbbreviation(string abbreviation, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<(int, string)>> GetAllName(string name, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<(int, string)>> GetAllDescription(string description, CancellationToken ct)
    {
        throw new NotImplementedException();
    }
}