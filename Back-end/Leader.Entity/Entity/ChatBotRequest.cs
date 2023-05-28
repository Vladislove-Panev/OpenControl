using Leader.Domain.Enums;

namespace Leader.Domain.Entity;

public class ChatBotRequest
{
    public Guid Id { get; set; }
    public DateTime Created { get; set; }
    public ChatBotRequestFeedBack? FeedBack { get; set; }
    public string? FeedBackString { get; set; }

    public long? UserId { get; set; }
    public User? User { get; set; }

    public int? DepartmentId { get; set; }
    public Department? Department { get; set; }
    
    public List<ChatBotRequestMessage>? ChatBotRequestMessages { get; set; }
}