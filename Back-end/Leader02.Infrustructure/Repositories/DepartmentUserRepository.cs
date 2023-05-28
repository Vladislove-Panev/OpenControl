using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class DepartmentUserRepository : BaseRepository<DepartmentUser>, IDepartmentUserRepository
{
    public DepartmentUserRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<DepartmentUser?> GetById(long id, CancellationToken ct)
    {
        return await DbContext.DepartmentUsers.FirstOrDefaultAsync(x => x.Id == id, cancellationToken: ct);
    }

    public async Task<DepartmentUser?> GetByEmail(string email, CancellationToken ct)
    {
        return await DbContext.DepartmentUsers.FirstOrDefaultAsync(x => x.Email == email, cancellationToken: ct);
    }

    public async Task<DepartmentUser?> GetByMobilePhone(string mobilePhone, CancellationToken ct)
    {
        return await DbContext.DepartmentUsers.FirstOrDefaultAsync(x => x.MobilePhone == mobilePhone, cancellationToken: ct);
    }

    public async Task<DepartmentUser?> GetByEmailAndPassword(string email, string password, CancellationToken ct)
    {
        return await DbContext.DepartmentUsers.FirstOrDefaultAsync(x => x.Email == email && x.Password == password, cancellationToken: ct);
    }
}