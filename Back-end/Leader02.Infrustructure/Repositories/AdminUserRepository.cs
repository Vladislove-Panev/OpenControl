using Leader.Domain.Entity;
using Leader.Domain.Interfaces;

namespace Leader02.Infrastructure.Repositories;

public class AdminUserRepository : BaseRepository<AdminUser>, IAdminUserRepository
{
    public AdminUserRepository(Leader02Context dbContext) : base(dbContext)
    {
    }
}