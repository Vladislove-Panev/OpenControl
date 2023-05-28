namespace Leader02.Application.DtoModels;

public class ConsultationTopicDto
{
    public int Id { get; set; }
    public string Topic { get; set; } = string.Empty;
    public SubDepartmentDto SubDepartment { get; set; } = new();
}