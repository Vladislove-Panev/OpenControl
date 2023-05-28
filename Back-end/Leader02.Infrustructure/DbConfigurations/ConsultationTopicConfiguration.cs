using Leader.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Leader02.Infrastructure.DbConfigurations;

public class ConsultationTopicConfiguration : IEntityTypeConfiguration<ConsultationTopic>
{
    public void Configure(EntityTypeBuilder<ConsultationTopic> builder)
    {
        builder.HasKey(x => x.Id);
    }
}