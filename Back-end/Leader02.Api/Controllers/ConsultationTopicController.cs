using Leader02.Application.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Leader02.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class ConsultationTopicController : ControllerBase
{
    private readonly IConsultationTopicService _consultationTopicService;

    public ConsultationTopicController(IConsultationTopicService consultationTopicService)
    {
        _consultationTopicService = consultationTopicService;
    }

    [HttpGet("by-sub-department/{id:int}")]
    public async Task<IActionResult> GetBySubDepartmentId(int id, CancellationToken ct)
    {
        var consultationTopics = await _consultationTopicService.GetAllBySubDepartmentId(id, ct);
        return Ok(consultationTopics);
    }
}