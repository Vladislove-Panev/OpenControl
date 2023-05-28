using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class LegalActTsVectorConfiguration : IEntityTypeConfiguration<LegalActTsVector>
{
    public void Configure(EntityTypeBuilder<LegalActTsVector> builder)
    {
        builder.HasKey(x => x.Id);
    }
}