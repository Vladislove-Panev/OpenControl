using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class LegalActConfiguration : IEntityTypeConfiguration<LegalAct>
{
    public void Configure(EntityTypeBuilder<LegalAct> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasOne(e => e.LegalActTsVectorName)
            .WithOne(e => e.LegalAct)
            .HasForeignKey<LegalActTsVector>();
    }
}