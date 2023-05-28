using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class ChatBotRequestMessageConfiguration : IEntityTypeConfiguration<ChatBotRequestMessage>
{
    public void Configure(EntityTypeBuilder<ChatBotRequestMessage> builder)
    {
        builder.HasKey(x => x.Id);
    }
}