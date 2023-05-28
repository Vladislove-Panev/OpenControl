using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class DepartmentConfiguration : IEntityTypeConfiguration<Department>
{
    public void Configure(EntityTypeBuilder<Department> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasMany(x => x.SubDepartments)
            .WithOne(x => x.Department)
            .HasForeignKey(x => x.DepartmentId);

        builder.HasMany(x => x.ChatBotRequests)
            .WithOne(x => x.Department)
            .HasForeignKey(x => x.DepartmentId);

        builder.HasMany(x => x.LegalActs)
            .WithOne(x => x.Department)
            .HasForeignKey(x => x.DepartmentId);
    }
}