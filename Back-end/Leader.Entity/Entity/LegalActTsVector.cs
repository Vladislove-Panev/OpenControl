namespace Leader.Domain.Entity;

public class LegalActTsVector
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;

    public LegalAct LegalAct { get; set; } = new();
}