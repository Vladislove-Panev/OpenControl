using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class SubDepartmentConfiguration : IEntityTypeConfiguration<SubDepartment>
{
    public void Configure(EntityTypeBuilder<SubDepartment> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasMany(x => x.DepartmentUsers)
            .WithOne(x => x.SubDepartment)
            .HasForeignKey(x => x.SubDepartmentId);

        builder.HasMany(x => x.ConsultationSlots)
            .WithOne(x => x.SubDepartment)
            .HasForeignKey(x => x.SubDepartmentId);

        builder.HasMany(x => x.ConsultationTopics)
            .WithOne(x => x.SubDepartment)
            .HasForeignKey(x => x.SubDepartmentId);

        builder.HasMany(x => x.LegalActs)
            .WithOne(x => x.SubDepartment)
            .HasForeignKey(x => x.SubDepartmentId);
        
        builder.HasMany(x => x.Requirements)
            .WithOne(x => x.SubDepartment)
            .HasForeignKey(x => x.SubDepartmentId);

        builder.HasOne(e => e.SubDepartmentTsVector)
            .WithOne(e => e.SubDepartment)
            .HasForeignKey<SubDepartmentTsVector>();
    }
}