using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class DepartmentUserConfiguration : IEntityTypeConfiguration<DepartmentUser>
{
    public void Configure(EntityTypeBuilder<DepartmentUser> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasMany(x => x.Consultations)
            .WithOne(x => x.DepartmentUser)
            .HasForeignKey(x => x.DepartmentUserId);
    }
}