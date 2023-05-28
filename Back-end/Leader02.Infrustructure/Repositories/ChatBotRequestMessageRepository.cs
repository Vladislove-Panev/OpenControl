using Leader.Domain.Entity;
using Leader.Domain.Interfaces;

namespace Leader02.Infrastructure.Repositories;

public class ChatBotRequestMessageRepository : BaseRepository<ChatBotRequestMessage>, IChatBotRequestMessageRepository
{
    public ChatBotRequestMessageRepository(Leader02Context dbContext) : base(dbContext)
    {
    }
}