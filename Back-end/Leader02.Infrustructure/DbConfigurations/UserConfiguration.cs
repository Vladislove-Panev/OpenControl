using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasKey(x => x.Id); 
        
        builder.HasMany(x => x.ChatBotRequests)
            .WithOne(x => x.User)
            .HasForeignKey(x => x.UserId);
        
        builder.HasMany(x => x.Consultations)
            .WithOne(x => x.User)
            .HasForeignKey(x => x.UserId);
    }
}