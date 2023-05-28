using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class OpenControlServiceConfiguration : IEntityTypeConfiguration<OpenControlService>
{
    public void Configure(EntityTypeBuilder<OpenControlService> builder)
    {
        builder.HasKey(x => x.Id);
    }
}