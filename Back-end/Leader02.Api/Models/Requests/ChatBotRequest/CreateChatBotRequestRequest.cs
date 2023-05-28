namespace Leader02.Api.Models.Requests.ChatBotRequest;

public class CreateChatBotRequestRequest
{
    public Guid? Id { get; set; }
    public long UserId { get; set; }
    public string Message { get; set; } = string.Empty;
}