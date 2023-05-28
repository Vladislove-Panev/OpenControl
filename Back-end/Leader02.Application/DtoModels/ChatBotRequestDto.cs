using Leader.Domain.Enums;

namespace Leader02.Application.DtoModels;

public class ChatBotRequestDto
{
    public Guid Id { get; set; }
    public DateTime Created { get; set; }
    public string RequestString { get; set; } = string.Empty;
    public ChatBotRequestFeedBack? FeedBack { get; set; }
    public string? FeedBackString { get; set; }
    public DepartmentDto? Department { get; set; }
    public List<ChatBotRequestMessageDto> ChatBotRequestMessages { get; set; } = new();
 }