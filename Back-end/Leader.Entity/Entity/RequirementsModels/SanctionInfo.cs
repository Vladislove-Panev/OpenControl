namespace Leader.Domain.Entity.RequirementsModels;

public class SanctionInfo
{
    /// <summary>
    /// Субъект ответственности
    /// </summary>
    public string? SubjectOfResponsibility { get; set; }	
    
    /// <summary>
    /// Санкция
    /// </summary>
    public string? Sanction { get; set; }

    /// <summary>
    /// Размер санкции
    /// </summary>
    public string? SizeOfSanction { get; set; }
}