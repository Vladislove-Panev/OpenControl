using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class SubDepartmentRepository : BaseRepository<SubDepartment>, ISubDepartmentRepository
{
    public SubDepartmentRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<SubDepartment?> GetById(int id, CancellationToken ct)
    {
        return await DbContext.SubDepartments
            .Where(x => x.Id == id)
            .Include(x => x.Department)
            .FirstOrDefaultAsync(cancellationToken: ct);
    }

    public async Task<List<SubDepartment>> GetAllByDepartmentId(int departmentId, CancellationToken ct)
    {
        return await DbContext.SubDepartments.Where(x => x.DepartmentId == departmentId).ToListAsync(ct);
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