namespace Leader02.Api.Models.Requests.ChatBotRequest;

public class GetChatBotRequestsRequest
{
    public long? UserId { get; set; }
    public int? DepartmentId { get; set; }
    public int PageIndex { get; set; }
    public int PageLimit { get; set; }
}