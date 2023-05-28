namespace Leader.Domain.Entity.RequirementsModels;

public class RequirementResponsibility
{
    /// <summary>
    /// Вид ответственности (уголовная /административная/ гражданско-правовая/иная ответственность)
    /// </summary>
    public string? TypeOfLiability { get; set; }
	
    /// <summary>
    /// Вид нормы (общая, специальная)
    /// </summary>
    public string? TypeOfNorm { get; set; } 	
    
    /// <summary>
    /// Указание на НПА (НПА, структурные единицы, текст нормы)
    /// </summary>
    public string? ReferenceToLegalAct { get; set; }	
    
    /// <summary>
    /// Орган, уполномоченный на привлечение к ответственности
    /// </summary>
    public string? EmpoweredToHoldAuthority { get; set; }	
    
    /// <summary>
    /// Порядок привлечения к ответственности (ссылка на файл без авторизации)
    /// </summary>
    public string? ResponsibilityBringingProcedure { get; set; }
    
    /// <summary>
    /// json модели SanctionInfo
    /// </summary>
    public string? SanctionInfoJson { get; set; }
}