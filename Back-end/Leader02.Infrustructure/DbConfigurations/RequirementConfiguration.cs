using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class RequirementConfiguration : IEntityTypeConfiguration<Requirement>
{
    public void Configure(EntityTypeBuilder<Requirement> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasOne(e => e.RequirementBasicRequirement)
            .WithOne(e => e.Requirement)
            .HasForeignKey<RequirementTsVector>();
    }
}