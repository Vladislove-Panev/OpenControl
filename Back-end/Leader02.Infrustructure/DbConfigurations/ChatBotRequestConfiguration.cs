using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class ChatBotRequestConfiguration : IEntityTypeConfiguration<ChatBotRequest>
{
    public void Configure(EntityTypeBuilder<ChatBotRequest> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasMany(x => x.ChatBotRequestMessages)
            .WithOne(x => x.ChatBotRequest)
            .HasForeignKey(x => x.ChatBotRequestId);
    }
}