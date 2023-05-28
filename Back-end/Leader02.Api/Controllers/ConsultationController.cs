using Leader02.Api.Models.Requests.Consultation;
using Leader02.Application.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Leader02.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class ConsultationController : ControllerBase
{
    private readonly IConsultationService _consultationService;

    public ConsultationController(IConsultationService consultationService)
    {
        _consultationService = consultationService;
    }

    [HttpPost("book")]
    public async Task<IActionResult> Book([FromBody] BookConsultationRequest request, CancellationToken ct)
    {
        var consultation = await _consultationService.CreateConsultation(request.Topic, request.UserId, request.ConsultationSlotId, ct);
        return Ok(consultation);
    }
}