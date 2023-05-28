using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class ConsultationSlotConfiguration : IEntityTypeConfiguration<ConsultationSlot>
{
    public void Configure(EntityTypeBuilder<ConsultationSlot> builder)
    {
        builder.HasKey(x => x.Id);
    }
}