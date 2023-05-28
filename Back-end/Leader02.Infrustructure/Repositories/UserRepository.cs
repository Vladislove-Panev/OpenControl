using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class UserRepository : BaseRepository<User>, IUserRepository
{
    public UserRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<User?> GetById(long id, CancellationToken ct)
    {
        return await DbContext.Users.FirstOrDefaultAsync(x => x.Id == id, cancellationToken: ct);
    }

    public async Task<User?> GetByEmail(string email, CancellationToken ct)
    {
        return await DbContext.Users.FirstOrDefaultAsync(x => x.Email == email, cancellationToken: ct);
    }

    public async Task<User?> GetByMobilePhone(string mobilePhone, CancellationToken ct)
    {
        return await DbContext.Users.FirstOrDefaultAsync(x => x.MobilePhone == mobilePhone, cancellationToken: ct);
    }

    public async Task<User?> GetByEmailAndPassword(string email, string password, CancellationToken ct)
    {
        return await DbContext.Users.FirstOrDefaultAsync(x => x.Email == email && x.Password == password, cancellationToken: ct);
    }
}