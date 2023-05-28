using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.DbConfigurations;

public static class ModelBuilderExtensions
{
    public static void DateTimeWithoutTimeZoneConfigure(this ModelBuilder builder)
    {
        foreach (var property in builder.Model.GetEntityTypes()
                     .SelectMany(t => t.GetProperties())
                     .Where
                     (p
                         => p.ClrType == typeof(DateTime)
                            || p.ClrType == typeof(DateTime?)
                     )
                )
        {
            property.SetColumnType("timestamp without time zone");
        }
    }
}