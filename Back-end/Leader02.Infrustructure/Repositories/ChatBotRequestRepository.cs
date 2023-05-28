using Leader.Domain.Entity;
using Leader.Domain.Interfaces;

namespace Leader02.Infrastructure.Repositories;

public class ChatBotRequestRepository : BaseRepository<ChatBotRequest>, IChatBotRequestRepository
{
    public ChatBotRequestRepository(Leader02Context dbContext) : base(dbContext)
    {
    }
}