using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class RequirementTsVectorConfiguration : IEntityTypeConfiguration<RequirementTsVector>
{
    public void Configure(EntityTypeBuilder<RequirementTsVector> builder)
    {
        builder.HasKey(x => x.Id);
    }
}