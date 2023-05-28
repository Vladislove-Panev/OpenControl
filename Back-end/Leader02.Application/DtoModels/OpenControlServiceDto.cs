namespace Leader02.Application.DtoModels;

public class OpenControlServiceDto
{
    public int Id { get; set; }
    public int Number { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string? OpenControlServiceUrl { get; set; }
}