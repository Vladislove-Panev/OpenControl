using Leader02.Application.DtoModels;

namespace Leader02.Api.Models.Response.ChatBotRequest;

public class GetChatBotRequestResponse
{
    public List<ChatBotRequestDto> ChatBotRequests { get; set; } = new();
}