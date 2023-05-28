using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class SubDepartmentTsVectorConfiguration : IEntityTypeConfiguration<SubDepartmentTsVector>
{
    public void Configure(EntityTypeBuilder<SubDepartmentTsVector> builder)
    {
        builder.HasKey(x => x.Id);
    }
}