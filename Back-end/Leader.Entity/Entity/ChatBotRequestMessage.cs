namespace Leader.Domain.Entity;

public class ChatBotRequestMessage
{
    public Guid Id { get; set; }
    public string Message { get; set; } = string.Empty;
    public int State { get; set; }
    
    public Guid? ChatBotRequestId { get; set; }
    public ChatBotRequest? ChatBotRequest { get; set; }
}