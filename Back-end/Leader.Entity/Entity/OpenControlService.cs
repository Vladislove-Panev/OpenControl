namespace Leader.Domain.Entity;

public class OpenControlService
{
    public int Id { get; set; }
    public int Number { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string? OpenControlServiceUrl { get; set; }
}