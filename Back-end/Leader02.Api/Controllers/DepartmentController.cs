using Leader02.Application.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Leader02.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class DepartmentController : ControllerBase
{
    private readonly IDepartmentService _departmentService;

    public DepartmentController(IDepartmentService departmentService)
    {
        _departmentService = departmentService;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll(CancellationToken ct)
    {
        var departments = await _departmentService.GetAll(ct);
        return Ok(departments);
    }
}