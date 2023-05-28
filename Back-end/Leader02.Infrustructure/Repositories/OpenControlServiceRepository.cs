using Leader.Domain.Entity;
using Leader.Domain.Interfaces;

namespace Leader02.Infrastructure.Repositories;

public class OpenControlServiceRepository : BaseRepository<OpenControlService>, IOpenControlServiceRepository
{
    public OpenControlServiceRepository(Leader02Context dbContext) : base(dbContext)
    {
    }
}