namespace Leader.Domain.Entity;

public class RequirementTsVector
{
    public long Id { get; set; }
    public int? Number { get; set; }
    public string? BasicRequirement { get; set; }

    public Requirement Requirement { get; set; } = new();
}